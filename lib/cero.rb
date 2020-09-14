# frozen_string_literal: true

require_relative 'client/factories/clients_factory.rb'
require_relative 'cli/arguments.rb'
require_relative 'services/configure_services.rb'

# Praise the sun
class Cero
  attr_reader :services, :clients, :arguments

  def initialize
    @services = ConfigureServices.new
    @arguments = Arguments.new.grab_guments(ARGV)
    @clients = ClientsFactory.new(@git, @arguments)
  end

  def begin
    @clients.sections[:operations].oss.run('get')
  end
end

Cero.new.begin
