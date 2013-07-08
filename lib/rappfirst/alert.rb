require 'json'

module Rappfirst
  class Alert

    include HTTParty
    format :json

    attr_accessor :id

    def writeable_attributes
      # Strip out attributes that are hard to serialize for now, because their API is weird
      ['name', 'active', 'direction', 'interval', 'time_above_threshold', 'threshold']
    end

    def writeable?(name)
      return writeable_attributes.include?(name)
    end

    def initialize(id, api_options=nil, json_data=nil)
      if api_options && api_options.keys.include?(:basic_auth)
        username = api_options[:basic_auth][:username]
        api_key = api_options[:basic_auth][:password]
      else
        username = get_config('username')
        api_key = get_config('password')
      end

      if api_options && api_options.keys.include?(:basic_uri)
        base_uri = api_options[:base_uri]
      else
        base_uri = 'https://wwws.appfirst.com/api'
      end

      self.class.basic_auth username, api_key
      self.class.base_uri base_uri

      self.id = id
      set_attributes(json_data=json_data)
    end

    def delete
      delete_self
    end

    def sync
      sync_self
    end

    private

      def sync_self
        payload = { :body => attributes_for_put_update }
        response = self.class.put("/alerts/#{self.id}/", payload)
        unless response.success?
          raise "Unable to sync alert #{self.id} with server, received HTTP code #{response.response}"
        end
      end

      def delete_self
        response = self.class.delete("/alerts/#{self.id}/")
        unless response.code == 200
          raise "Unable to delete server, received HTTP code #{response.code}"
        end
      end

      def attributes_to_hash
        h = Hash.new
        writeable_attributes.each do |a|
          h[a] = self.instance_variable_get('@' + a)
        end
        h
      end

      def attributes_for_put_update
        attributes_to_hash.map do |k,v|
          "#{k}=#{v}"
        end.join('&')
      end

      def set_attributes(json_data=nil)
        if not json_data
          response = get_attributes
        else
          response = json_data
        end
        response.each do |name, v|
          create_method( "#{name}=".to_sym ) { |val|
            if ! instance_variable_get("@" + name)
              instance_variable_set("@" + name, val)
            elsif self.writeable?(name) && instance_variable_get("@" + name)
              instance_variable_set("@" + name, val)
            end
          }

          create_method( name.to_sym ) {
            instance_variable_get("@" + name)
          }

          instance_variable_set("@" + name, v)
        end
      end

      def get_attributes
        return self.class.get("/alerts/#{self.id}/")
      end

      def create_method(name, &block)
        self.class.send(:define_method, name, &block)
      end

      def get_config(key)
        config = YAML::load( File.open('config.yml'))
        return config[key]
      end

  end
end