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

      def initialize(services, args)
        @services = services
        @feature = args.deq
        @command = args.deq
      end

      ## Return available sections.
      def sections(section)
        section = section.to_sym

        pick = {
          media: MediaClient.new(services, command),
          # projects: ProjectsClient.new(services, command),
          operation: OperationsClient.new(services, command)
          # distro: DistroClient.new
        }

        pick[section].features[feature]
      end
    end
  end
end
