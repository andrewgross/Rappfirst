module Rappfirst
  class Server
    include HTTParty

    def initialize(id, api_options=nil)
      if api_options && api_options.keys.include?(:auth)
        username = api_options[:auth][:username]
        api_key = api_options[:auth][:api_key]
      else
        config = YAML::load( File.open( 'config.yml') )
        username = config['username']
        api_key = config['password']
      end
      base_uri = api_options[:base_uri] ||= 'https://wwws.appfirst.com/api/v3'

      self.class.basic_auth username, api_key
      self.class.base_uri base_uri
    end

    #response = self.class.get("/servers/#{id}/")

  end
end