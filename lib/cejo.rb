# frozen_string_literal: true

require_relative 'cejo/version'

# * Services
require_relative 'cejo/services/folders'
require_relative 'cejo/services/utils'

# * Floss
require_relative 'cejo/floss/main'
require_relative 'cejo/floss/project_info'
require_relative 'cejo/floss/archive'
require_relative 'cejo/floss/grab'

# * Projects
require_relative 'cejo/projects/builder'
require_relative 'cejo/projects/projects_parser'
require_relative 'cejo/projects/project_info'
require_relative 'cejo/projects/main'

# * Media

# ** Play
require_relative 'cejo/media/play/players'
require_relative 'cejo/media/play/play'

# ** Get
require_relative 'cejo/media/get/main'
require_relative 'cejo/media/get/grabbers'
require_relative 'cejo/media/get/info'
require_relative 'cejo/media/get/parser'
require_relative 'cejo/media/get/get'
