require_relative '../../spec_helper'

describe Rappfirst::Server do
 
  describe "default attributes" do

    it "must include httparty methods" do
      Rappfirst::Server.must_include HTTParty
    end
 
    it "must have the base url set to the Appfirst API" do
      Rappfirst::Server.
      instance_variable_get("@default_options")[:base_uri].
      must_equal 'https://wwws.appfirst.com/api/v3'
    end
 
    it "must have API Credentials" do
      Rappfirst::Client.
      instance_variable_get("@default_options")[:basic_auth].
      keys.must_include(:username)
    end

  end

  describe "Populate attributes" do

    let(:server) { Rappfirst::Server.new('11743') }

    before do
      VCR.insert_cassette 'server', :record => :new_episodes
    end
   
    after do
      VCR.eject_cassette
    end

    it "must populate the hostname attribute" do
      server.must_respond_to :hostname
    end

    it "must make the hostname attribute read-only" do
      h = server.hostname
      server.hostname = "foobar"
      server.hostname.must_equal h
    end

    it "must populate the nickname attribute" do
      server.must_respond_to :nickname
    end

    it "must make the nickname attribute writeable" do
      n = server.nickname
      server.nickname = "foobar"
      server.nickname.wont_equal n
    end


  end

end