# frozen_string_literal: true

require 'shellwords'

require_relative 'cero/client/factories/clients_factory.rb'
require_relative 'cero/cli/arguments.rb'
require_relative 'cero/services/configure_services.rb'

# Debian Utilities.
module Cero
  # Praise the sun
  class Start
    attr_reader :services, :clients, :arguments, :section

    def initialize
      @services = Cero::Services::ConfigureServices.new

      @arguments = Cero::Cli::Arguments.new.grab_arguments(ARGV)
      @section = arguments.deq

      @clients = Cero::Client::ClientsFactory.new(services, arguments)
    end

    def run
      clients.sections(section)
    end
  end
end

Cero::Start.new.run
