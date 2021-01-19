# frozen_string_literal: true

require_relative '../clients/distro_client'
require_relative '../clients/operations_client'
require_relative '../clients/projects_client'
require_relative '../clients/media_client'

module Cero
  module Client
    # Provide Clients
    class ClientsFactory
      attr_reader :services, :feature, :command, :subcommand

      private

      def initialize(services, command, subcommand)
        @services = services
        @command = command
        @subcommand = subcommand
      end

      def operations
        OperationsClient.new(services, command)
      end

      def media
        MediaClient.new(services, command, subcommand)
      end

      def projects
        ProjectsClient.new(services, command)
      end

      def distro
        DistroClient.new(services, command)
      end

      public

      ## Return available sections.
      def sections
        {
          media: media,
          operation: operations,
          projects: projects,
          distro: distro
        }
      end
    end
  end
end
