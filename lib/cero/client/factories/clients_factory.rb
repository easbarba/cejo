# frozen_string_literal: true

require_relative '../clients/distro_client.rb'
require_relative '../clients/operations_client.rb'
require_relative '../clients/projects_client.rb'
require_relative '../clients/media_client.rb'

module Cero
  module Client
    # Provide Clients
    class ClientsFactory
      attr_reader :services, :args, :module, :command

      def initialize(services, args)
        @services = services
        @module = args.deq
        @command = args
      end

      ## Return available sections.
      def sections
        {
          media: MediaClient.new(command).modules[:module],
          operation: OperationsClient.new(services, command).modules[:module]
          # projects: ProjectsClient.new(git, command).modules[module],
          # distro: DistroClient.new
        }
      end
    end
  end
end
