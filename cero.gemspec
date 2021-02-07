# frozen_string_literal: true

Gem::Specification.new do |spec|
  spec.name          = 'cero'.freeze
  spec.summary       = 'Miscellaneous Unix automation and services utilities.'.freeze
  spec.description   = File.read(File.join(File.dirname(__FILE__), 'README.org'))
  spec.version       = '0.0.1'
  spec.authors       = ['EAS Barbosa'.freeze]
  spec.email         = ['easbarbosa@pm.me'.freeze]

  spec.platform      = Gem::Platform::RUBY
  spec.required_ruby_version = '>=2.7'.freeze
  spec.homepage      = 'https://gitlab.com/easbarbosa/cero'.freeze
  spec.metadata['homepage_uri'] = spec.homepage
  spec.license = 'GPL-3.0'.freeze

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(tes|spec|features)/}) }
  end

  spec.require_paths = ['lib']
  spec.bindir        = 'exe'
  spec.executables   = %w[cero]
  spec.has_rdoc      = false
  %w[bundler pry reek shoulda].each do |dep|
    spec.add_development_dependency dep
  end

  spec.required_ruby_version = Gem::Requirement.new('>= 2.7.0'.freeze)
end
