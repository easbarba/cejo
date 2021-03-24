# frozen_string_literal: true

# * Root
require_relative 'cejo/version'

# * Services
require_relative 'cejo/services/folders'
require_relative 'cejo/services/utils'

# * Ops
require_relative 'cejo/ops/homey'
require_relative 'cejo/ops/screenshot'
require_relative 'cejo/ops/volume'
require_relative 'cejo/ops/brightness'
require_relative 'cejo/ops/dots'
require_relative 'cejo/ops/sysinfo'

# * Floss
require_relative 'cejo/floss/core'
require_relative 'cejo/floss/project_info'
require_relative 'cejo/floss/archive'
require_relative 'cejo/floss/grab'

# * Distro
require_relative 'cejo/distro/base'
require_relative 'cejo/distro/translate_action'
require_relative 'cejo/distro/parsed_commands'
require_relative 'cejo/distro/commands'
require_relative 'cejo/distro/current_packager'
require_relative 'cejo/distro/need'

# * Projects
require_relative 'cejo/projects/builder'
require_relative 'cejo/projects/emacs'
require_relative 'cejo/projects/dwm'
require_relative 'cejo/projects/st'
require_relative 'cejo/projects/ruby'

# * Media
require_relative 'cejo/media/play'
require_relative 'cejo/media/get'
