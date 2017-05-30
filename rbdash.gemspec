# coding: utf-8

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rbdash/version'

Gem::Specification.new do |spec|
  spec.name          = 'rbdash'
  spec.version       = Rbdash::VERSION
  spec.authors       = ['shotat']
  spec.email         = ['shotat@users.noreply.github.com']

  spec.summary       = 'Configuration management tools for re:dash'
  spec.description   = 'Configuration management tools for re:dash'
  spec.homepage      = 'https://github.com/shotat/rbdash'

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'httparty'
  spec.add_dependency 'thor'
  spec.add_dependency 'diffy'
  spec.add_development_dependency 'bundler', '~> 1.15'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
end
