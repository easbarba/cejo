# frozen_string_literal: true

require 'dry-container'

# Miscellaneous Unix automation and services utilities.
module Cejo
  # Bootstrap program
  class Base
    private

    attr_reader :section, :feature, :arguments

    def services
      container = Dry::Container.new
      container.register(:folders, Services::Folders.new)
      container.register(:utils, Services::Utils.new)
    end

    def deploy_arguments
      args = CLI::Arguments.new(ARGV).values

      @section = args[:command]
      @feature = args[:option]
      @arguments = args[:arguments]
    end

    # Inform user about sections and commands available
    def help
     main = Cejo::CLI::Help::Main.new(section, feature, arguments)
     main.validate
     main.run
    end

    def hives
      Hive::Queen.new(services, arguments)
    end

    public

    def run
      deploy_arguments
      help
      hives.sections[section].features[feature].run
    end
  end
end
