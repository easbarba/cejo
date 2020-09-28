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
        @feature = args.deq
        @command = args.deq
      end

      def operations
        OperationsClient.new(services, command).features[:feature]
      end

      def media
        MediaClient.new(services, command).features[:feature]
      end

      # def projects
      #   ProjectsClient.new(services, command).features[feature]
      # end

      # def distro
      #   DistroClient.new(services, command).run
      # end

      public

      def all_sections
        {
          operation: operations,
          media: media,
          # projects: projects,
          # distro: distro
        }
      end

      ## Return available sections.
      def sections
        all_sections
      end
    end
  end
end
