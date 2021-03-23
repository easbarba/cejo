# frozen_string_literal: true

namespace :docs do
  task :man do
    gem man '/man/cejo.1.ronn'
  end
end
