require_relative '../../spec_helper'

describe Rappfirst::Server do
 
  describe "default attributes" do
 
    it "must include httparty methods" do
      Rappfirst::Server.must_include HTTParty
    end
 
    it "must have the base url set to the Appfirst API endpoint" do
      Rappfirst::Server.base_uri.must_equal 'https://wwws.appfirst.com/api/v3'
    end
 
    it "must have API Credentials" do
      Rappfirst::Server.
      instance_variable_get("@default_options").
      keys.must_include(:basic_auth)
    end

  end
 
  describe "GET profile" do
 
    before do
      VCR.insert_cassette 'server', :record => :new_episodes
    end
   
    after do
      VCR.eject_cassette
    end
   
    it "records the fixture" do
      Rappfirst::Server.get('/servers/')
    end
   
  end

end