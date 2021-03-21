# frozen_string_literal: true

require 'dry-container'

require_relative 'hives'

# * Help
require_relative 'arguments'
require_relative 'help'

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
      cli = Arguments.new(ARGV)
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

    def run = Hives.new(services, rest).sections(section, feature)
  end
end
