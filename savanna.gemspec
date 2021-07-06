# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'savanna/version'

Gem::Specification.new do |spec|
  spec.name          = "savanna"
  spec.version       = Savanna::VERSION
  spec.authors       = ["Shawn Jung", "Danny Lai"]
  spec.email         = ["shawn.jung@me.com", "danny.lai@queosystems.com"]
  spec.description   = %q{Make your sprockets environment by one commend.}
  spec.summary       = %q{It makes sprockets environment.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 2.1.2"
  spec.add_development_dependency "rake"
  spec.add_dependency 'rack'
  spec.add_dependency 'sprockets',         '>= 3.0', '< 4.0'
  spec.add_dependency 'sprockets-sass', '2.0.0.beta2'
  spec.add_dependency 'sprockets-helpers', '~> 1.0'
  spec.add_dependency 'sass', '~> 3.3'
  spec.add_dependency 'compass', "~> 1.0.0.alpha.19"
  spec.add_dependency 'coffee-script'
  spec.add_dependency 'ejs'
  spec.add_dependency 'yui-compressor'
  spec.add_dependency 'uglifier'

end
