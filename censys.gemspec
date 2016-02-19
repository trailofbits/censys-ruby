# -*- encoding: utf-8 -*-

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'censys/version'

Gem::Specification.new do |gem|
  gem.name          = "censys"
  gem.version       = CenSys::VERSION
  gem.summary       = %q{API client for censys.io}
  gem.description   = %q{Ruby API client for the CenSys Internet search engine.}
  gem.license       = "MIT"
  gem.authors       = ["Hal Brodigan"]
  gem.email         = "hal@trailofbits.com"
  gem.homepage      = "https://github.com/trailofbits/censys-ruby#readme"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ['lib']

  gem.add_development_dependency 'bundler', '~> 1.10'
  gem.add_development_dependency 'rake', '~> 10.0'
  gem.add_development_dependency 'rspec', '~> 3.0'
  gem.add_development_dependency 'rubygems-tasks', '~> 0.2'
  gem.add_development_dependency 'yard', '~> 0.8'
end
