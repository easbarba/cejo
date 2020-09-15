# frozen_string_literal: true

require_relative '../clients/distro_client.rb'
require_relative '../clients/operations_client.rb'
require_relative '../clients/projects_client.rb'

module Cero
  module Client
    # Provide Clients
    class ClientsFactory
      attr_reader :git, :args, :module, :command

      def initialize(git, args)
        @git = git
        @module = args.deq.to_sym
        @command = args
      end

      ## Return available sections.
      def sections
        {
          operations: OperationsClient.new(@git, @command).modules[@module]
          # projects: ProjectsClient.new(@git, @command).modules[@module],
          # distro: DistroClient.new
        }
      end
    end
  end
end
