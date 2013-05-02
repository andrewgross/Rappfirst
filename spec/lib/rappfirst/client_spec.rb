require_relative '../../spec_helper'

describe Rappfirst::Client do
 
  describe "default attributes" do
 
    it "must include httparty methods" do
      Rappfirst::Client.must_include HTTParty
    end
 
    it "must have the base url set to the Appfirst API" do
      Rappfirst::Client.base_uri.must_equal 'https://wwws.appfirst.com/api/v3'
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
     
      it "must perform the request and get valid data" do
        client.servers.each { |s| s.keys().must_include 'id' }
      end

    end

    describe "Get specific server" do
      
      before do
        VCR.insert_cassette 'server', :record => :new_episodes
      end
     
      after do
        VCR.eject_cassette
      end

      it "must accept query parameters without a question mark" do
        client.servers(query='hostname=yipit-linkedin-worker2').
        size.must_equal 1
      end

      it "must accept query parameters with a question mark" do
        client.servers(query='?hostname=yipit-linkedin-worker2').
        size.must_equal 1
      end

    end

  end

end