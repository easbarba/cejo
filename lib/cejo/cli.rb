# frozen_string_literal: true

require_relative 'cli/base'
require_relative 'services/container'
require_relative 'client/factories/clients'

# Miscellaneous Unix automation and services utilities.
module Cejo
  class CLI
    private

    attr_reader :services, :args

    def initialize
      @services = Cejo::Services::Container.new
      @args = CLI::Base.arguments(ARGV)
    end

    def clients
      sub_option = args.sub_option

      Cejo::Client::Clients.new(services, sub_option)
    end

    def run
      section = args.command
      feature = args.option

      clients.sections[section].features[feature].run
    end
    public :run
  end
end
