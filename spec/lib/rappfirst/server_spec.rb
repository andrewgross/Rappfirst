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

  describe "attributes" do

    let(:server) { Rappfirst::Server.new('11743') }

    before do
      VCR.insert_cassette 'server', :record => :new_episodes
    end
   
    after do
      VCR.eject_cassette
    end

    describe "retrieve and create methods" do

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

    describe "cache data" do

      before do
        server.polled_data
        stub_request(:any, /wwws.appfirst.com/).to_timeout
      end

      it "must cache attributes" do
        skip "TODO: Implement Refreshing of base attributes"
        lambda { server.hostname }.must_raise Timeout::Error
      end

    end

  end

  describe "polled data config" do

    let(:server) { Rappfirst::Server.new('11743') }

    before do
      VCR.insert_cassette 'server', :record => :new_episodes
    end
   
    after do
      VCR.eject_cassette
    end

    it "must have a polled data method" do
      server.must_respond_to :polled_data
    end

    it "must fetch the current polled data config" do
      server.polled_data.must_be_instance_of Hash
    end

    it "must have proper results" do
      ["file_type", "file_contents", "server_id", "file_path", "frequency"].each do |key|
        server.polled_data.keys.must_include(key)
      end
    end

    it "must have a polled data setter" do
      server.must_respond_to :polled_data=
    end

    it "must upload new configs" do
      skip "API is returning 500 Errors"
      current_data = server.polled_data.clone
      new_data = current_data.clone
      new_data['frequency'] = 600
      server.polled_data = new_data
      server.polled_data(refresh=true)['frequency'].wont_equal current_data['frequency'] 
    end

    before do
      server.polled_data
      stub_request(:any, /wwws.appfirst.com/).to_timeout
    end

    it "must refresh the results if forced" do
      lambda { server.polled_data(refresh=true) }.must_raise Timeout::Error
    end

  end

  describe "outages" do
    
    let(:server) { Rappfirst::Server.new('11743') }

    before do
      VCR.insert_cassette 'server', :record => :new_episodes
    end
     
    after do
      VCR.eject_cassette
    end

    describe "retrieve data" do

      it "must have an outages method" do
        server.must_respond_to :outages
      end

      it "must retrieve outage data" do
        server.outages.must_be_instance_of Array
      end

    end

    describe "cached data" do

      before do
        server.polled_data
        stub_request(:any, /wwws.appfirst.com/).to_timeout
      end

      it "must cache outage data" do
        lambda { server.outages(refresh = true) }.must_raise Timeout::Error
      end

    end

  end

end