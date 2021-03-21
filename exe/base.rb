# frozen_string_literal: true

require 'dry-container'

# * Cli
require_relative 'cli/arguments'
require_relative 'cli/help/queen_help'
require_relative 'cli/help/media_help'
require_relative 'cli/help/projects_help'
require_relative 'cli/help/floss_help'
require_relative 'cli/help/distro_help'
require_relative 'cli/help/ops_help'

# * Hives
require_relative 'hive/queen'
require_relative 'hive/distro_hive'
require_relative 'hive/floss_hive'
require_relative 'hive/ops_hive'
require_relative 'hive/projects_hive'
require_relative 'hive/media_hive'

# Miscellaneous Unix automation and services utilities.
module Cejo
  # Bootstrap program
  class Base
    attr_reader :section, :feature, :rest, :args

    def initialize
      prepare_args
      @section = args[:command]
      @feature = args[:option]
      @rest = args[:rest]
    end

    def prepare_args
      cli = CLI::Arguments.new(ARGV)
      cli.show_help
      @args = cli.values
    end
    private :prepare_args

    def services
      container = Dry::Container.new
      container.register(:folders, Services::Folders.new)
      container.register(:utils, Services::Utils.new)
    end
    private :services

    public

    def run
      hives = Hive::Queen.new(services, rest)
      hives.sections[section]
           .features[feature]
           .run
    end
  end
end
