# frozen_string_literal: true

require 'dry-container'

# Miscellaneous Unix automation and services utilities.
module Cejo
  # Bootstrap program
  class Base
    private

    def services
      container = Dry::Container.new
      container.register(:folders, Services::Folders.new)
      container.register(:utils, Services::Utils.new)
    end

    def cli_arguments
      CLI::Arguments.new(ARGV).values
    end

    def hives
      sub_option = cli_arguments[:arguments]
      Hive::Queen.new(services, sub_option)
    end

    public

    def run
      section = cli_arguments[:command]
      feature = cli_arguments[:option]

      hives.sections[section].features[feature].run
    end
  end
end
