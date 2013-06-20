# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'savanna/version'

Gem::Specification.new do |spec|
  spec.name          = "savanna"
  spec.version       = Savanna::VERSION
  spec.authors       = ["Shawn Jung"]
  spec.email         = ["shawn.jung@me.com"]
  spec.description   = %q{Make your sprockets environment by one commend.}
  spec.summary       = %q{It makes sprockets environment.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_dependency 'rack'
  spec.add_dependency 'sprockets'
  spec.add_dependency 'sprockets-sass'
  spec.add_dependency 'sprockets-helpers'
  spec.add_dependency 'sass'
  spec.add_dependency 'compass'
  spec.add_dependency 'coffee-script'
  spec.add_dependency 'ejs'

end
