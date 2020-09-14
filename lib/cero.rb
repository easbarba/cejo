# frozen_string_literal: true

require_relative 'client/factories/clients_factory.rb'
require_relative 'cli/arguments.rb'
require_relative 'services/configure_services.rb'

module Cero
  # Praise the sun
  class Start
    attr_reader :services, :clients, :arguments

    def initialize
      @services = ConfigureServices.new
      @arguments = Arguments.new.grab_guments(ARGV)
      @clients = ClientsFactory.new(@services.git, @arguments)
    end

    def begin
      # @clients.sections[:operations].oss.run('get')
    end
  end
end

Cero::Start.new.begin
