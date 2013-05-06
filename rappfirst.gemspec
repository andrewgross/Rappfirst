# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rappfirst/version'

Gem::Specification.new do |gem|
  gem.name          = "rappfirst"
  gem.version       = Rappfirst::VERSION
  gem.authors       = ["Andrew Gross"]
  gem.email         = ["andrew.w.gross@gmail.com"]
  gem.description   = "See Readme.md"
  gem.summary       = "Appfirst API v3 Wrapper"
  gem.homepage      = "https://github.com/andrewgross/rappfirst"
  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.require_paths = ["lib"]

  gem.add_runtime_dependency 'httparty'
  
  gem.add_development_dependency 'debugger'
  gem.add_development_dependency 'webmock'
  gem.add_development_dependency 'vcr'
  gem.add_development_dependency 'turn'
  gem.add_development_dependency 'rake'
end
