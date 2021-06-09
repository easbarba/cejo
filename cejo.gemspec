# frozen_string_literal: true

require_relative 'lib/cejo/version'

Gem::Specification.new do |s|
  s.name = 'cejo'
  s.summary = 'Debian automation and services utilities.'
  s.description = File.read(File.join(File.dirname(__FILE__), 'README.rdoc'))
  s.version = Cejo::VERSION
  s.author = 'EAS Barbosa'
  s.email = 'easbarbosa@tutanota.com'
  s.homepage = 'https://git.sr.ht/~easbarbosa/cejo'
  s.license = 'GPL-3.0'
  s.require_paths = ['lib']
  s.bindir = 'bin'
  s.executables = 'cejo'
  s.post_install_message = 'Praise the sun!'
  s.platform = Gem::Platform.local
  s.test_files = Dir.glob('{spec,test}/**/*.rb')
  s.metadata['homepage_uri'] = s.homepage
  s.required_ruby_version = Gem::Requirement.new('>= 2.7')
  s.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(tes|spec|features)/}) }
  end
  s.rdoc_options = ['--main'.freeze, 'README.rdoc'.freeze]

  s.metadata = {
    'bug_tracker_uri' => 'https://git.sr.ht/~easbarbosa/cejo',
    'changelog_uri' => "https://git.sr.ht/~easbarbosa/cejo/refs/v#{s.version}/History.rdoc",
    'homepage_uri' => 'https://git.sr.ht/~easbarbosa/cejo',
    'source_code_uri' => 'https://git.sr.ht/~easbarbosa/cejo'
  }

  # requirements
  s.requirements << 'ffmpeg'
  s.requirements << 'libyaml'
  s.requirements << 'mpv'

  # runtime
  s.add_runtime_dependency 'dry-auto_inject', '~> 0.7.0'
  s.add_runtime_dependency 'dry-container', '~> 0.7.2'
  s.add_runtime_dependency 'git', '~> 1.8', '>= 1.8.1'
  s.add_runtime_dependency 'gli', '~> 2.20'
  s.add_runtime_dependency 'tty-spinner', '~> 0.9.3'
  s.add_runtime_dependency 'yaml', '~> 0.1.1'

  # development
  s.add_development_dependency 'bundler', '~> 2.2', '>= 2.2.17'
  s.add_development_dependency 'minitest', '~> 5.14', '>= 5.14.4'
  s.add_development_dependency 'pry', '~> 0.14.1'
  s.add_development_dependency 'rake', '~> 13.0', '>= 13.0.3'
  s.add_development_dependency 'rdoc', '~> 6.3', '>= 6.3.1'
  s.add_development_dependency 'reek', '~> 6.0', '>= 6.0.4'
  s.add_development_dependency 'rspec', '~> 3.10'
  s.add_development_dependency 'rubocop', '~> 1.15'
  s.add_development_dependency 'rubocop-rspec', '~> 2.3'
  s.add_development_dependency 'rufo', '~> 0.12.0'
  s.add_development_dependency 'yard', '~> 0.9.26'
  s.add_development_dependency 'solargraph', '~> 0.40.4'
end
