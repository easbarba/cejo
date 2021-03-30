# frozen_string_literal: true

require 'rspec/core/rake_task'

namespace :container do
  task :build do
    sh 'podman run -ti -rm cejo'
  end

  task :run do
    sh 'podman build -t cejo .'
  end
end
