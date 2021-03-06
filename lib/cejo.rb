# frozen_string_literal: true

require 'bundler/setup'

require_relative 'cejo/version'

# * Services
require_relative 'cejo/services/folders'
require_relative 'cejo/services/utils'

# * Projects
require_relative 'cejo/builder'
require_relative 'cejo/projects_parser'
require_relative 'cejo/project_info'
require_relative 'cejo/main'

# Build Floss Projects
module Cejo
end
