# frozen_string_literal: true

require_relative 'cli/arguments'
require_relative 'services/configure_services'
require_relative 'client/factories/clients_factory'

# Miscellaneous Unix automation and services utilities.
module Cejo
  # and so it begins...
  class Startup
    SERVICES = Cejo::Services::ConfigureServices.new # TODO: Use IoC

    attr_reader :arguments

    private

    def initialize
      @arguments = Cejo::Cli::Arguments.new.grab_arguments(ARGV)
    end

    def clients
      command = arguments.deq unless arguments.empty?
      subcommand = arguments.deq unless arguments.empty?

      Cejo::Client::ClientsFactory.new(SERVICES, command, subcommand)
    end

    public

    def run
      section = arguments.deq.to_sym
      feature = arguments.deq.to_sym

      clients.sections[section].features[feature].run
    end
  end
end
