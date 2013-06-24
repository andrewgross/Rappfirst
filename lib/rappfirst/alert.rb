module Rappfirst
  class Alert

    include HTTParty
    format :json

    attr_accessor :id

    def initialize(id, api_options=nil)
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
        base_uri = 'https://wwws.appfirst.com/api/v3'
      end

      self.class.basic_auth username, api_key
      self.class.base_uri base_uri

      self.id = id
      set_attributes
    end

    def delete
      delete_self
    end

    private

      def delete_self
        response = self.class.delete("/alerts/#{self.id}/")
        unless response.code == 200
          raise "Unable to delete server, received HTTP code #{response.code}"
        end
      end

      def set_attributes
        response = get_attributes
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