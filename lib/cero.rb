# frozen_string_literal: true

require_relative 'cero/client/factories/clients_factory'
require_relative 'cero/cli/arguments'
require_relative 'cero/services/configure_services'

# Unix Utilities.
module Cero
  # and so it begins...
  class Begin
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
      clients.sections[section]
             .features[feature]
             .run
    end
  end
end

Cero::Begin.new.run
