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
 
    # it "must have API Credentials" do
    #   Rappfirst::Client.
    #   instance_variable_get("@default_options")[:basic_auth].
    #   keys.must_include(:username)
    # end

  end

end