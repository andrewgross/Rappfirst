module Rappfirst
  class Client
    include HTTParty
    format :json

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
      response = get_servers(query_string)
      if response.length == 1 && query_string
        return server(response.first['id'])
      else
        s = Array.new
        response.each do |r|
          s << server(r['id'])
        end
        return s
      end
    end

    def server(id)
      api_options = self.class.default_options
      Rappfirst::Server.new(id, api_options=api_options)
    end

    def alert(id)
      Rappfirst::Alert.new(id)
    end

    private

      def get_servers(query_string=nil)
        if query_string && ! query_string.start_with?('?')
          query_string = '?' + query_string
        end
        self.class.get("/servers/#{query_string}")
      end

  end
end
