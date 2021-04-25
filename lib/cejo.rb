# frozen_string_literal: true

# * Root
require_relative 'cejo/version'

# * Services
require_relative 'cejo/services/folders'
require_relative 'cejo/services/utils'

# * Ops
require_relative 'cejo/ops/homey'
require_relative 'cejo/ops/screenshot'
require_relative 'cejo/ops/volume/volume'
require_relative 'cejo/ops/volume/sound_manager'
require_relative 'cejo/ops/brightness'
require_relative 'cejo/ops/dots'
require_relative 'cejo/ops/sysinfo'

# * Floss
require_relative 'cejo/floss/main'
require_relative 'cejo/floss/project_info'
require_relative 'cejo/floss/archive'
require_relative 'cejo/floss/grab'

# * Distro
require_relative 'cejo/distro/main'
require_relative 'cejo/distro/translate_action'
require_relative 'cejo/distro/parsed_commands'
require_relative 'cejo/distro/commands'
require_relative 'cejo/distro/current_packager'
require_relative 'cejo/distro/need'

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
