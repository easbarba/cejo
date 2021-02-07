# frozen_string_literal: true

require 'cli/arguments'
require 'services/configure_services'
require 'client/factories/clients_factory'

# Miscellaneous Unix automation and services utilities.
module Cero
  # and so it begins...
  class Startup
    SERVICES = Cero::Services::ConfigureServices.new # TODO: Use IoC

    attr_reader :arguments

    private

    def initialize
      @arguments = Cero::Cli::Arguments.new.grab_arguments(ARGV)
    end

    def clients
      command = arguments.deq unless arguments.empty?
      subcommand = arguments.deq unless arguments.empty?

      Cero::Client::ClientsFactory.new(SERVICES, command, subcommand)
    end

    public

    def run
      section = arguments.deq.to_sym
      feature = arguments.deq.to_sym

      clients.sections[section].features[feature].run
    end
  end
end
