# frozen_string_literal: true

require_relative 'cli/arguments'
require_relative 'client/factories/clients_factory'
require_relative 'services/configure_services'

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

    def services
      Cero::Services::ConfigureServices.new # TODO: Use IoC
    end

    def clients
      command = arguments.deq
      Cero::Client::ClientsFactory.new(services, command)
    end

    public

    def run
      clients.sections[section].features[feature].run
    end
  end
end
