# frozen_string_literal: true

require 'cli/arguments'
require 'services/configure_services'
require 'client/factories/clients_factory'

# Unix Utilities.
module Cero
  # and so it begins...
  class Startup
    attr_reader :arguments, :section, :feature

    private

    def initialize
      @arguments = Cero::Cli::Arguments.new.grab_arguments(ARGV)
      @section = arguments.deq.to_sym
      @feature = arguments.deq.to_sym
    end

    # TODO: Use IoC
    def services
      Cero::Services::ConfigureServices.new
    end

    def clients
      command = arguments.empty? ? nil : arguments.deq
      subcommand = arguments.empty? ? nil : arguments.deq
      Cero::Client::ClientsFactory.new(services, command, subcommand)
    end

    public

    def run
      clients.sections[section].features[feature].run
    end
  end
end
