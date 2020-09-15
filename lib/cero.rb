# frozen_string_literal: true

require_relative 'client/factories/clients_factory.rb'
require_relative 'cli/arguments.rb'
require_relative 'services/configure_services.rb'

# Debian Utilities.
module Cero
  # Praise the sun
  class Start
    attr_reader :services, :clients, :arguments, :section

    def initialize
      @services = Cero::Services::ConfigureServices.new

      @arguments = Cero::Cli::Arguments.new.grab_arguments(ARGV)
      @section = @arguments.deq.to_sym

      @clients = Cero::Client::ClientsFactory.new(@services.git, @arguments)
    end

    def begin
      @clients.sections[@section]
    end
  end
end

Cero::Start.new.begin
