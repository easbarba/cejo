# frozen_string_literal: true

# * Root
require_relative 'cejo/base'

# * Cli
require_relative 'cejo/cli/arguments'
require_relative 'cejo/cli/help/main'
require_relative 'cejo/cli/help/media_help'
require_relative 'cejo/cli/help/projects_help'
require_relative 'cejo/cli/help/floss_help'
require_relative 'cejo/cli/help/distro_help'
require_relative 'cejo/cli/help/ops_help'

# * Hives
require_relative 'cejo/hive/queen'
require_relative 'cejo/hive/hives/distro_hive'
require_relative 'cejo/hive/hives/floss_hive'
require_relative 'cejo/hive/hives/ops_hive'
require_relative 'cejo/hive/hives/projects_hive'
require_relative 'cejo/hive/hives/media_hive'

# * Services
require_relative 'cejo/services/container'
require_relative 'cejo/services/folders'
require_relative 'cejo/services/utils'

# * Sections

# ** Ops
require_relative 'cejo/sections/ops/homey'
require_relative 'cejo/sections/ops/screenshot'
require_relative 'cejo/sections/ops/volume'
require_relative 'cejo/sections/ops/brightness'
require_relative 'cejo/sections/ops/dots'
require_relative 'cejo/sections/ops/sysinfo'

# *** Floss
require_relative 'cejo/sections/floss/core'
require_relative 'cejo/sections/floss/project_info'
require_relative 'cejo/sections/floss/archive'
require_relative 'cejo/sections/floss/grab'

# ** Distro
require_relative 'cejo/sections/distro/base'
require_relative 'cejo/sections/distro/translate_action'
require_relative 'cejo/sections/distro/config_folder'
require_relative 'cejo/sections/distro/commands'
require_relative 'cejo/sections/distro/current_packager'
require_relative 'cejo/sections/distro/need'

# ** Projects
require_relative 'cejo/sections/projects/builder'
require_relative 'cejo/sections/projects/emacs'
require_relative 'cejo/sections/projects/dwm'
require_relative 'cejo/sections/projects/st'
require_relative 'cejo/sections/projects/ruby'

# ** Media
require_relative 'cejo/sections/media/play'
require_relative 'cejo/sections/media/get'
