# frozen_string_literal: true

require_relative 'cero/client/factories/clients_factory'
require_relative 'cero/cli/arguments'
require_relative 'cero/services/configure_services'

# Unix Utilities.
module Cero
  # and so it begins...
  class Begin
    attr_reader :arguments

    private

    def initialize
      @arguments = Cero::Cli::Arguments.new.grab_arguments(ARGV)
    end

    def services
      Cero::Services::ConfigureServices.new # TODO: Use IoC
    end

    def clients
      Cero::Client::ClientsFactory.new(services, arguments)
    end

    public

    def run
      section = arguments.deq.to_sym
      clients.sections[section]
    end
  end
end

Cero::Begin.new.run
