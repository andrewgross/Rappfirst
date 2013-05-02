require_relative "../lib/rappfirst"

require 'minitest/autorun'
require "minitest/spec"
require 'webmock/minitest'
require 'vcr'
require 'turn'

# Turn Config
Turn.config do |c|
 # :outline  - turn's original case/test outline mode [default]
 c.format  = :outline
 # use humanized test names (works only with :outline format)
 c.natural = true
end

# VCR config
VCR.configure do |c|
  c.cassette_library_dir = 'spec/fixtures/rappfirst_cassettes'
  c.hook_into :webmock
end

