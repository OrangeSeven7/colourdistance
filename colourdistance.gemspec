# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'colourdistance/version'
require 'rake/extensiontask'

Gem::Specification.new do |spec|
  spec.name          = "colourdistance"
  spec.version       = Colourdistance::VERSION
  spec.authors       = ["Orange Seven"]
  spec.email         = ["theseventhorange@gmail.com"]

  spec.summary       = "Measures the difference (as a distance between colors in lab space) between colours. Takes rgb input. Will add support for xyz and lab around version 1.0."
  spec.description   = "Currently contains four options (ciede 76, cmclc, ciede94, and ciede2000) (all here: https://en.wikipedia.org/wiki/Color_difference), all weighted so that the distance between rgb 0,0,0 and rgb 255,255,255 will be 1.000 (accurate to 4 decimal places). Will add more. All are my own implementations (although ciede2000 is based on several dozen implementations found during research), and they may be wrong because of it. If you see any problems, let me know. Thanks go out to Josh Clayton (https://robots.thoughtbot.com/get-your-c-on), for helping me to understand the structure I was attempting to acheive."
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
  spec.extensions = ["ext/colourdistance/extconf.rb"]

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
  spec.add_dependency "rake-compiler"

  Rake::ExtensionTask.new("colourdistance") do |extension|
    extension.lib_dir = "lib/colourdistance"
  end
end
