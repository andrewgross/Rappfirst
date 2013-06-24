require_relative '../../spec_helper'

describe Rappfirst::Alert do

  describe "default attributes" do

    let(:alert) { Rappfirst::Alert.new('114140') }

    before do
      VCR.insert_cassette 'single_alert', :record => :new_episodes
    end

    after do
      VCR.eject_cassette
    end

    it "must include httparty methods" do
      Rappfirst::Alert.must_include HTTParty
    end

    it "must have the base url set to the Appfirst API" do
      alert.class.base_uri.must_equal 'https://wwws.appfirst.com/api/v3'
    end

    it "must have API Credentials" do
      alert.class.default_options[:basic_auth].keys.must_include(:username)
      alert.class.default_options[:basic_auth].keys.must_include(:password)
    end

  end


  describe "attributes" do

    let(:alert) { Rappfirst::Alert.new('114140') }

    before do
      VCR.insert_cassette 'single_alert', :record => :new_episodes
    end

    after do
      VCR.eject_cassette
    end

    describe "retrieve and create methods" do

      it "must populate the target attribute" do
        alert.must_respond_to :target
      end

    end

  end


end