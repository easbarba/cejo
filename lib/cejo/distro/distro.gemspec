# Ensure we require the local version and not one we might have installed already
require File.join([File.dirname(__FILE__),'lib','distro','version.rb'])

spec = Gem::Specification.new do |s|
  s.name = 'distro'
  s.version = Distro::VERSION
  s.author = 'EAS Barbosa'
  s.email = 'easbarbosa@tutanota.com'
  s.homepage = 'https://git.sr.ht/~easbarbosa/'
  s.license = 'GPL-3.0'
  s.platform = Gem::Platform::RUBY
  s.summary = 'A description of your project'
  s.files = `git ls-files`.split("
")
  s.require_paths << 'lib'
  s.extra_rdoc_files = ['README.rdoc','distro.rdoc']
  s.rdoc_options << '--title' << 'distro' << '--main' << 'README.rdoc' << '-ri'
  s.bindir = 'bin'
  s.executables << 'distro'
  s.test_files = Dir.glob('{spec,test}/**/*.rb')

  # development deps
  s.add_development_dependency('rake','~> 0.9.2')
  s.add_development_dependency('rdoc', '~> 4.3')
  s.add_development_dependency('minitest', '~> 5.14')
  s.add_development_dependency 'pry', '~> 0.14.1'
  s.add_development_dependency 'rake', '~> 13.0', '>= 13.0.3'
  s.add_development_dependency 'reek', '~> 6.0', '>= 6.0.4'
  s.add_development_dependency 'rspec', '~> 3.10'
  s.add_development_dependency 'rubocop', '~> 1.15'
  s.add_development_dependency 'rubocop-rspec', '~> 2.3'
  s.add_development_dependency 'rufo', '~> 0.12.0'
  s.add_development_dependency 'solargraph', '~> 0.40.4'

  # runtime deps
  s.add_runtime_dependency 'dry-auto_inject', '~> 0.7.0'
  s.add_runtime_dependency 'dry-container', '~> 0.7.2'
  s.add_runtime_dependency('gli','~> 2.20.0')
  s.add_runtime_dependency 'yaml', '~> 0.1.1'
end
