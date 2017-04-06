# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'resque/plugins/compressible'

Gem::Specification.new do |spec|
  spec.name          = "resque-compressible"
  spec.version       = Resque::Plugins::Compressible::VERSION
  spec.authors       = ["Misha Conway"]
  spec.email         = ["mishaAconway@gmail.com"]

  spec.summary       = %q{Compress resque job payloads!}
  spec.description   = %q{Compress resque job payloads!}
  spec.homepage      = "https://github.com/MishaConway/resque-compressible"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.12"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
end
