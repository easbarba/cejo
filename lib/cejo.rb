# frozen_string_literal: true

# * Root
require_relative 'cejo/base'

# * Cli
require_relative 'cejo/cli/arguments'
require_relative 'cejo/cli/help/queen_help'
require_relative 'cejo/cli/help/media_help'
require_relative 'cejo/cli/help/projects_help'
require_relative 'cejo/cli/help/floss_help'
require_relative 'cejo/cli/help/distro_help'
require_relative 'cejo/cli/help/ops_help'

# * Hives
require_relative 'cejo/hive/queen'
require_relative 'cejo/hive/distro_hive'
require_relative 'cejo/hive/floss_hive'
require_relative 'cejo/hive/ops_hive'
require_relative 'cejo/hive/projects_hive'
require_relative 'cejo/hive/media_hive'

# * Services
require_relative 'cejo/services/container'
require_relative 'cejo/services/folders'
require_relative 'cejo/services/utils'

# ** Ops
require_relative 'cejo/ops/homey'
require_relative 'cejo/ops/screenshot'
require_relative 'cejo/ops/volume'
require_relative 'cejo/ops/brightness'
require_relative 'cejo/ops/dots'
require_relative 'cejo/ops/sysinfo'

# *** Floss
require_relative 'cejo/floss/core'
require_relative 'cejo/floss/project_info'
require_relative 'cejo/floss/archive'
require_relative 'cejo/floss/grab'

# ** Distro
require_relative 'cejo/distro/base'
require_relative 'cejo/distro/translate_action'
require_relative 'cejo/distro/config_folder'
require_relative 'cejo/distro/commands'
require_relative 'cejo/distro/current_packager'
require_relative 'cejo/distro/need'

# ** Projects
require_relative 'cejo/projects/builder'
require_relative 'cejo/projects/emacs'
require_relative 'cejo/projects/dwm'
require_relative 'cejo/projects/st'
require_relative 'cejo/projects/ruby'

# ** Media
require_relative 'cejo/media/play'
require_relative 'cejo/media/get'
