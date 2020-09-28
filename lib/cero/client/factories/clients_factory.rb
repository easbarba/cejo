# frozen_string_literal: true

require_relative '../clients/distro_client.rb'
require_relative '../clients/operations_client.rb'
require_relative '../clients/projects_client.rb'
require_relative '../clients/media_client.rb'

module Cero
  module Client
    # Provide Clients
    class ClientsFactory
      attr_reader :services, :args, :feature, :command

      private

      def initialize(services, args)
        @services = services
        @feature = args.deq
        @command = args.deq
      end

      def media
        MediaClient.new(services, command)
      end

      def projects
        ProjectsClient.new(services, command)
      end

      def operations
        OperationsClient.new(services, command)
      end

      def distro
        DistroClient.new(services, command)
      end

      public

      ## Return available sections.
      def sections(section)
        pick = {
          media: media,
          projects: projects,
          operation: operations,
          distro: distro
        }

        pick[section.to_sym].features[feature]
      end
    end
  end
end
