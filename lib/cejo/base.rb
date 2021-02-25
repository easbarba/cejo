# frozen_string_literal: true

require_relative 'cli/arguments'
require_relative 'services/container'
require_relative 'client/factories/clients'

# Miscellaneous Unix automation and services utilities.
module Cejo
  # Bootstrap program
  class Base
    private

    def services
      Services::Container.new
    end

    def args
      CLI::Arguments.new(ARGV).get_args
    end

    def clients
      sub_option = args.sub_option
      Client::Clients.new(services, sub_option)
    end

    def run
      section = args.command
      feature = args.option
      clients.sections[section].features[feature].run
    end

    public :run
  end
end
