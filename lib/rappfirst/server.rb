module Rappfirst
  class Server

    include HTTParty

    base_uri 'https://wwws.appfirst.com/api/v3'

    config = YAML::load( File.open( 'config.yml') )

    basic_auth config['username'], config['password']
  end
end
