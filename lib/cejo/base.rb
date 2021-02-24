# frozen_string_literal: true

require_relative 'cli/arguments'
require_relative 'services/container'
require_relative 'client/factories/clients'

# Miscellaneous Unix automation and services utilities.
module Cejo
  # Bootstrap program
  class Base
    private

    attr_reader :services, :args

    def initialize
      @services = Cejo::Services::Container.new
      @args = Cejo::CLI::Arguments.new(ARGV).get_args
    end

    def clients
      sub_option = args.sub_option

      Cejo::Client::Clients.new(services, sub_option)
    end

    def run
      section = args.command
      feature = args.option

      clients.sections[section].features[feature].run
    end
    public :run
  end
end
