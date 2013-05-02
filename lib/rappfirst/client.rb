module Rappfirst
  class Client
    include HTTParty

    def initialize(username=nil, api_key=nil)
      if username.nil? || api_key.nil?
        config = YAML::load( File.open( 'config.yml') )
        username = config['username']
        api_key = config['password']
      end
      self.class.basic_auth username, api_key
      self.class.base_uri 'https://wwws.appfirst.com/api/v3'
    end

    def servers(query_string=nil)
      if query_string && ! query_string.start_with?('?')
        query_string = '?' + query_string
      end
      self.class.get("/servers/#{query_string}")
    end

    def server(id)
      api_options = self.class.default_options
      Rappfirst::Server.new(id, api_options=api_options)
    end

  end
end
