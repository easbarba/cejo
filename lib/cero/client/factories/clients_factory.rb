# frozen_string_literal: true

require_relative '../clients/distro_client'
require_relative '../clients/operations_client'
require_relative '../clients/projects_client'
require_relative '../clients/media_client'

module Cero
  module Client
    # Provide Clients
    class ClientsFactory
      attr_reader :services, :feature, :command

      private

      def initialize(services, args)
        @services = services
        @feature = args.deq.to_sym
        @command = args.deq
      end

      def operations
        OperationsClient.new(services, command).features[feature]
      end

      def media
        MediaClient.new(services, command).features[feature]
      end

      def projects
        ProjectsClient.new(services, command).features[feature]
      end

      def distro
        DistroClient.new(services, command).run
      end

      public

      ## Return available sections.
      def sections
        {
          operation: operations,
          media: media,
          projects: projects,
          distro: distro
        }
      end
    end
  end
end
