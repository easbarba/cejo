# frozen_string_literal: true

require 'dry-container'

# Miscellaneous Unix automation and services utilities.
module Cejo
  # Bootstrap program
  class Base
    attr_reader :section, :feature, :arguments

    private

    def initialize
      args = CLI::Arguments.new(ARGV).values
      @section = args[:command]
      @feature = args[:option]
      @arguments = args[:arguments]
    end

    def services
      container = Dry::Container.new
      container.register(:folders, Services::Folders.new)
      container.register(:utils, Services::Utils.new)
    end

    # Inform user about sections and commands available
    def show_help
      main = Cejo::CLI::Help::Main.new(section, feature)
      main.validate
    end

    public

    def run
      show_help

      hives = Hive::Queen.new(services, arguments)
      hives.sections[section]
           .features[feature]
           .run
    end
  end
end
