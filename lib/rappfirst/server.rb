module Rappfirst
  class Server
    include HTTParty

    def initialize(id, api_options=nil)
      if api_options && api_options.keys.include?(:auth)
        username = api_options[:auth][:username]
        api_key = api_options[:auth][:api_key]
      else
        username = get_config('username')
        api_key = get_config('password')
      end
      base_uri = api_options[:base_uri] ||= 'https://wwws.appfirst.com/api/v3'

      self.class.basic_auth username, api_key
      self.class.base_uri base_uri
    end
    #response = self.class.get("/servers/#{id}/")

    private

    def get_config(key)
      config = YAML::load( File.open( 'config.yml') )
      return config[key]
    end

  end
end