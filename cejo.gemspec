# frozen_string_literal: true

Gem::Specification.new do |spec|
  spec.name          = 'cejo'.freeze
  spec.summary       = 'Debian automation and services utilities.'.freeze
  spec.description   = File.read(File.join(File.dirname(__FILE__), 'README.org'))
  spec.version       = '0.0.3'
  spec.author        = 'EAS Barbosa'.freeze
  spec.email         = 'easbarbosa@tutanota.com'.freeze
  spec.platform      = Gem::Platform::RUBY
  spec.homepage      = 'https://git.sr.ht/~easbarbosa/cejo'.freeze
  spec.license       = 'GPL-3.0'.freeze
  spec.require_paths = ['lib']
  spec.bindir        = 'exe'
  spec.executables   = %w[cejo]
  spec.test_files    = Dir.glob("{spec,test}/**/*.rb")
  spec.metadata['homepage_uri'] = spec.homepage
  spec.required_ruby_version = Gem::Requirement.new('>= 3.0.0'.freeze)
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(tes|spec|features)/}) }
  end

  # production
  spec.add_runtime_dependency 'git'
  spec.add_runtime_dependency 'tty-spinner'
  spec.add_runtime_dependency 'colorize'
  spec.add_runtime_dependency 'dry-container'
  spec.add_runtime_dependency 'dry-auto_inject'
  spec.add_runtime_dependency 'terminal-table'

  # development
  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'solargraph'
  spec.add_development_dependency 'sorbet'
  spec.add_development_dependency 'coderay'
  spec.add_development_dependency 'gli'
  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'rufo'
  spec.add_development_dependency 'reek'
  spec.add_development_dependency 'shoulda'
end
