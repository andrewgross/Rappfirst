require_relative '../../spec_helper'

describe Rappfirst::Server do
 
  describe "default attributes" do
 
    it "must include httparty methods" do
      Rappfirst::Server.must_include HTTParty
    end
 
    it "must have the base url set to the Appfirst API endpoint" do
      Rappfirst::Server.base_uri.must_equal 'https://wwws.appfirst.com/api/v3'
    end
 
  end
 
end