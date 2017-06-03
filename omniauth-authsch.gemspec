# -*- encoding: utf-8 -*-
# frozen_string_literal: true

require File.expand_path(
  File.join('..', 'lib', 'omniauth', 'authsch', 'version'),
  __FILE__
)

Gem::Specification.new do |gem|
  gem.name          = 'omniauth-authsch'
  gem.version       = OmniAuth::Authsch::VERSION
  gem.license       = 'MIT'
  gem.summary       = 'An Auth.sch strategy for OmniAuth 1.x'
  gem.description   = 'An Auth.sch strategy for OmniAuth 1.x. This allows you to login to Auth.sch with your ruby app.'
  gem.authors       = ['Zsolt Kozaroczy']
  gem.email         = ['kiskoza@sch.bme.hu']
  gem.homepage      = 'https://github.com/kiskoza/omniauth-authsch'

  gem.files         = `git ls-files`.split("\n")
  gem.require_paths = ['lib']

  gem.required_ruby_version = '>= 2.0'

  gem.add_runtime_dependency 'omniauth-oauth2', '~> 1.4'

  gem.add_development_dependency 'rspec', '~> 3.6'
  gem.add_development_dependency 'rake', '~> 12.0'
  gem.add_development_dependency 'rubocop', '~> 0.49'
end
