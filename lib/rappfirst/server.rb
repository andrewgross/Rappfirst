module Rappfirst
  class Server
    include HTTParty

    attr_accessor :id

    def writeable?(name)
      return ['description', 'nickname'].include?(name)
    end

    def initialize(id, api_options=nil)
      if api_options && api_options.keys.include?(:basic_auth)
        username = api_options[:basic_auth][:username]
        api_key = api_options[:basic_auth][:api_key]
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

    def polled_data(refresh = false)
      refresh ? @polled_data = get_polled_data : @polled_data ||= get_polled_data
    end

    def polled_data=(new_polled_data_config)
      #set_polled_data(new_polled_data_config)
    end


    private

      def get_polled_data
        return self.class.get("/servers/#{self.id}/polled_data_config/")
      end

      def set_polled_data(config)
        return self.class.put("/servers/#{self.id}/polled_data_config/", config)
      end

      def set_attributes
        response = self.class.get("/servers/#{self.id}/")
        response.each do |name, v|
          create_method( "#{name}=".to_sym ) { |val| 
            if ! instance_variable_get("@" + name)
              instance_variable_set("@" + name, val)
            elsif self.writeable?(name) && instance_variable_get("@" + name)
              instance_variable_set("@" + name, val)
            end
          }

          create_method( name.to_sym ) { 
            instance_variable_get("@" + name ) 
          }

          instance_variable_set("@" + name, v)
        end
      end

      def create_method( name, &block )
        self.class.send( :define_method, name, &block )
      end

      def get_config(key)
        config = YAML::load( File.open('config.yml'))
        return config[key]
      end

  end
end