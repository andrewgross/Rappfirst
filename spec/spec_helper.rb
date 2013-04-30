require_relative "../lib/rappfirst"

require 'minitest/autorun'
require 'webmock/minitest'
require 'vcr'
require 'turn'

# Turn Config
Turn.config do |c|
 # :outline  - turn's original case/test outline mode [default]
 c.format  = :outline
 # turn on invoke/execute tracing, enable full backtrace
 c.trace   = true
 # use humanized test names (works only with :outline format)
 c.natural = true
end

# VCR config
VCR.configure do |c|
  c.cassette_library_dir = 'spec/fixtures/rappfirst_cassettes'
  c.hook_into :webmock
end

