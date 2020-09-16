Gem::Specification.new do |spec|
  spec.name        = 'cero'
  spec.version     = '0.0.1'
  spec.date        = '2020-09-05'

  spec.authors     = ['E. Alexander Barbosa']
  spec.email       = 'elxbarbosa@outlook.com'

  spec.summary     = 'Debian utilities and software interface.'
  spec.homepage    = 'https://rubygems.org/gems/cero'
  spec.license     = 'GPL-3.0'

  spec.files       = ['lib/cero.rb']

  spec.required_ruby_version = '~> 2.7.1'

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'reek'
  spec.add_development_dependency 'rspec'
end
