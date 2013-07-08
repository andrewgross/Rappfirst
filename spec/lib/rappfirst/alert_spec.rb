require_relative '../../spec_helper'

describe Rappfirst::Alert do

  describe "default attributes" do

    let(:alert) { Rappfirst::Alert.new('121038') }

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
      alert.class.base_uri.must_equal 'https://wwws.appfirst.com/api'
    end

    it "must have API Credentials" do
      alert.class.default_options[:basic_auth].keys.must_include(:username)
      alert.class.default_options[:basic_auth].keys.must_include(:password)
    end

  end


  describe "attributes" do

    let(:alert) { Rappfirst::Alert.new('121038') }

    before do
      VCR.insert_cassette 'single_alert', :record => :new_episodes
    end

    after do
      VCR.eject_cassette
    end

    describe "retrieve and create methods" do

      it "must populate the id attribute" do
        alert.must_respond_to :id
      end

      it "must make the id attribute unwriteable" do
        n = alert.id
        alert.id = "foobar"
        alert.id.wont_equal "foobar"
      end

      it "must populate the name attribute" do
        alert.must_respond_to :name
      end

      it "must make the name attribute writeable" do
        n = alert.name
        alert.name = "foobar"
        alert.name.wont_equal n
      end

    end



  end

  describe "delete alert" do

    let(:alert) { Rappfirst::Alert.new('121038') }

    before do
      VCR.insert_cassette 'single_alert', :record => :new_episodes
    end

    after do
      VCR.eject_cassette
    end

    describe "signature" do

      it "must have a deletion method" do
        alert.must_respond_to :delete
      end

    end

    describe "failed deletion" do

      before do
        stub_request(:any, /wwws.appfirst.com/).
        to_return(:status => [500, "Internal Server Error"])
      end

      it "must delete itself" do
        lambda { alert.delete }.must_raise RuntimeError
      end

    end

  end


end