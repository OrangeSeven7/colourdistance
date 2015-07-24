# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'colourdistance/version'

Gem::Specification.new do |spec|
  spec.name          = "colourdistance"
  spec.version       = Colourdistance::VERSION
  spec.authors       = ["Orange Seven"]
  spec.email         = ["theseventhorange@gmail.com"]

  spec.summary       = "Measures the difference (as a distance between colors in lab space) between colours. Takes rgb input. Will add support for xyz and lab around version 1.0."
  spec.description   = "Currently only contains two options, ciede94 and ciede2000, both weighted to (roughly) a [0,1] scale (actually possible to get very slightly above 1). Will add more. Both are my own implementations, and ciede94 is probably wrong because of it."
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
end
