# frozen_string_literal: true

# Miscellaneous Unix automation and services utilities.
module Cejo
  # Bootstrap program
  class Base
    private

    def services
      Services::Container.new
    end

    def args
      CLI::Arguments.new(ARGV).get_args
    end

    def hives
      sub_option = args.sub_option
      Hive::Queen.new(services, sub_option)
    end

    public

    def run
      section = args.command
      feature = args.option
      hives.sections[section].features[feature].run
    end
  end
end
