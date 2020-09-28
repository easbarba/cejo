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
        @command = args.size.zero? ? nil : args.deq
      end

      public

      ## Return available sections.
      def sections(section)
        section = section.to_sym

        pick = {
          media: MediaClient.new(services, command),
          projects: ProjectsClient.new(services, command),
          operation: OperationsClient.new(services, command),
          distro: DistroClient.new(services, command)
        }

        pick[section].features[feature.to_sym]
      end
    end
  end
end
