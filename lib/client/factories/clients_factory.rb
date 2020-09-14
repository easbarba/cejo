# frozen_string_literal: true

require_relative '../clients/distro_client.rb'
require_relative '../clients/operations_client.rb'
require_relative '../clients/projects_client.rb'

module Cero
  module Client
    # Provide Clients
    class ClientsFactory
      attr_reader :git, :args

      def initialize(git, args)
        @git = git
        @args = args
      end

      ## Return available sections.
      def sections
        {
          operations: OperationsClient.new(@git),
          projects: ProjectsClient.new,
          distro: DistroClient.new
        }
      end
    end
  end
end
