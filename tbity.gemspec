# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'tbity/version'

Gem::Specification.new do |spec|
  spec.name          = "tbity"
  spec.version       = Tbity::VERSION
  spec.authors       = ["tbpgr"]
  spec.email         = ["tbpgr@tbpgr.jp"]

  spec.summary       = %q{activity logger.}
  spec.description   = %q{activity logger.}
  spec.homepage      = "https://github.com/tbpgr/tbity"

  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "!"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "thor", "~> 0.19"
  spec.add_dependency 'dotenv', '~> 2.1'

  spec.add_development_dependency 'simplecov', '~> 0.10'
  spec.add_development_dependency 'bundler', '~> 1.12'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'pry', '~> 0.10'
  spec.add_development_dependency 'rb-readline', '~> 0.5.3'
  spec.add_development_dependency 'bump', '~> 0.5'
end
