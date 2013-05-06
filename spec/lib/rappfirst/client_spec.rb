require_relative '../../spec_helper'

describe Rappfirst::Client do
 
  describe "default attributes" do
 
    it "must include httparty methods" do
      Rappfirst::Client.must_include HTTParty
    end
 
    it "must have the base url set to the Appfirst API" do
      Rappfirst::Client.
      instance_variable_get("@default_options")[:base_uri].
      must_equal 'https://wwws.appfirst.com/api/v3'
    end
 
    it "must have API Credentials" do
      Rappfirst::Client.
      instance_variable_get("@default_options")[:basic_auth].
      keys.must_include(:username)
    end

  end
 
  describe "GET servers" do
 
    let(:client) { Rappfirst::Client.new }

    describe "Get all servers" do

      before do
        VCR.insert_cassette 'servers', :record => :new_episodes
      end
     
      after do
        VCR.eject_cassette
      end
     
      it "must have a servers method" do
        client.must_respond_to :servers
      end
     
      it "must parse the api response from JSON to Hash" do
        client.servers.must_be_instance_of Array
      end

      it "should return an array of server objects" do
        client.servers.each { |s| s.must_be_instance_of Rappfirst::Server}
      end

    end

    describe "Get specific server" do
      
      before do
        VCR.insert_cassette 'search_for_server', :record => :new_episodes
      end
     
      after do
        VCR.eject_cassette
      end

      it "must accept query parameters without a question mark" do
        client.servers(query='hostname=yipit-linkedin-worker2').
        must_be_instance_of Rappfirst::Server
      end

      it "should return a server object" do
        client.servers(query='?hostname=yipit-linkedin-worker2').
        must_be_instance_of Rappfirst::Server
      end

    end

  end

  describe "Query single server" do
 
    let(:client) { Rappfirst::Client.new }

    before do
      VCR.insert_cassette 'single_server', :record => :new_episodes
    end

    after do
      VCR.eject_cassette
    end

    it "must have a server method" do
      client.must_respond_to :server
    end

    it "must return a server object" do
      client.server('11743').must_be_instance_of Rappfirst::Server
    end

  end

end