# frozen_string_literal: true

require_relative 'lib/cejo/version'

Gem::Specification.new do |spec|
  spec.name = 'cejo'
  spec.summary = 'Debian automation and services utilitiespec.'
  spec.description = File.read(File.join(File.dirname(__FILE__), 'README.rdoc'))
  spec.version = Cejo::VERSION
  spec.author = 'Dyna B'
  spec.email = 'dynab@tutanota.com'
  spec.homepage = 'https://git.sr.ht/~dynab/cejo'
  spec.license = 'GPL-3.0'
  spec.require_paths = ['lib']
  spec.bindir = 'exe'
  spec.executables = 'cejo'
  spec.platform = Gem::Platform.local
  spec.test_files = Dir.glob('{spec,test}/**/*.rb')
  spec.metadata['homepage_uri'] = spec.homepage
  spec.required_ruby_version = Gem::Requirement.new('>= 2.7')
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(tes|spec|features)/}) }
  end
  spec.rdoc_options = ['--main', 'README.rdoc']

  spec.metadata = {
    'bug_tracker_uri' => 'https://git.sr.ht/~dynab/cejo',
    'changelog_uri' => "https://git.sr.ht/~dynab/cejo/refs/v#{spec.version}/History.rdoc",
    'homepage_uri' => 'https://git.sr.ht/~dynab/cejo',
    'source_code_uri' => 'https://git.sr.ht/~dynab/cejo'
  }

  # requirements
  # spec.requirements << 'ffmpeg'

  # runtime
  spec.add_runtime_dependency 'dry-auto_inject', '~> 0.7.0'
  spec.add_runtime_dependency 'dry-container', '~> 0.7.2'
  spec.add_runtime_dependency 'git', '~> 1.8', '>= 1.8.1'
  spec.add_runtime_dependency 'gli', '~> 2.20'
  spec.add_runtime_dependency 'tty-spinner', '~> 0.9.3'
  spec.add_runtime_dependency 'yaml', '~> 0.1.1'

  # development
  spec.add_development_dependency 'bundler', '~> 2.2', '>= 2.2.21'
  spec.add_development_dependency 'minitest', '~> 5.14', '>= 5.14.4'
  spec.add_development_dependency 'pry', '~> 0.14.1'
  spec.add_development_dependency 'rake', '~> 13.0', '>= 13.0.3'
  spec.add_development_dependency 'rdoc', '~> 6.3', '>= 6.3.1'
  spec.add_development_dependency 'reek', '~> 6.0', '>= 6.0.4'
  spec.add_development_dependency 'rubocop', '~> 1.15'
  spec.add_development_dependency 'rubocop-rspec', '~> 2.3'
  spec.add_development_dependency 'rufo', '~> 0.12.0'
  spec.add_development_dependency 'solargraph', '~> 0.40.4'
  spec.add_development_dependency 'yard', '~> 0.9.26'
end
