# frozen_string_literal: true

require_relative 'lib/cero/version'

Gem::Specification.new do |spec|
  spec.name          = 'cero'
  spec.version       = Cero::VERSION
  spec.authors       = ['EAS Barbosa']
  spec.email         = ['easbarbosa@pm.me']

  spec.summary       = 'Miscellaneous Unix toolings front-end and utilities'
  spec.homepage      = 'https://gitlab.com/elxbarbosa/cero'
  spec.metadata['homepage_uri'] = spec.homepage
  spec.license = 'GPL-3.0'

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(tes|spec|features)/}) }
  end

  spec.require_paths = ['lib']
  spec.bindir        = 'exe'
  spec.executables = %w[cero]

  %w[bundler pry reek shoulda].each do |dep|
    spec.add_development_dependency dep
  end

  spec.required_ruby_version = Gem::Requirement.new('>= 2.7.0')
end
