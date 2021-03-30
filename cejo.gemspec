# frozen_string_literal: true

require_relative 'lib/cejo/version'

Gem::Specification.new do |spec|
  spec.name = 'cejo'
  spec.summary = 'Debian automation and services utilities.'
  spec.description = File.read(File.join(File.dirname(__FILE__), 'README.rdoc'))
  spec.version = Cejo::VERSION
  spec.author = 'EAS Barbosa'
  spec.email = 'easbarbosa@tutanota.com'
  spec.homepage = 'https://git.sr.ht/~easbarbosa/cejo'
  spec.license = 'GPL-3.0'
  spec.require_paths = ['lib']
  spec.bindir = 'exe'
  spec.executables = 'cejo'
  spec.post_install_message = 'Praise the sun!'
  spec.platform = Gem::Platform.local
  spec.test_files = Dir.glob('{spec,test}/**/*.rb')
  spec.metadata['homepage_uri'] = spec.homepage
  spec.required_ruby_version = Gem::Requirement.new('>= 2.7')
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(tes|spec|features)/}) }
  end
  spec.extra_rdoc_files = %w[README.rdoc cejo.rdoc]
  spec.rdoc_options << '--title' << 'cejo' << '--main' << 'README.rdoc' << '-ri'

  spec.metadata = {
    'bug_tracker_uri' => 'https://git.sr.ht/~easbarbosa/cejo',
    'changelog_uri' => 'https://git.sr.ht/~easbarbosa/cejo/tree/main/item/CHANGELOG.md',
    'homepage_uri' => 'https://git.sr.ht/~easbarbosa/cejo',
    'source_code_uri' => 'https://git.sr.ht/~easbarbosa/cejo'
  }

  # requirements
  spec.requirements << 'linux distros'
  spec.requirements << 'ffmpeg'
  spec.requirements << 'mpv'

  # production
  spec.add_runtime_dependency('dry-auto_inject')
  spec.add_runtime_dependency('dry-container')
  spec.add_runtime_dependency('git')
  spec.add_runtime_dependency('gli')
  spec.add_runtime_dependency('tty-spinner')

  # development
  spec.add_development_dependency('bundler')
  spec.add_development_dependency('coderay')
  spec.add_development_dependency('gem-man')
  spec.add_development_dependency('minitest')
  spec.add_development_dependency('pry')
  spec.add_development_dependency('rake')
  spec.add_development_dependency('rdoc')
  spec.add_development_dependency('reek')
  spec.add_development_dependency('ronn')
  spec.add_development_dependency('rspec')
  spec.add_development_dependency('rubocop')
  spec.add_development_dependency('rufo')
  spec.add_development_dependency('shoulda')
  spec.add_development_dependency('solargraph')
  spec.add_development_dependency('sorbet')
end
