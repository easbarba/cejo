# frozen_string_literal: true

require_relative '../clients/distro_client'
require_relative '../clients/ops_client'
require_relative '../clients/projects_client'
require_relative '../clients/media_client'

module Cejo
  module Client
    # Provide Clients
    class Clients
      attr_reader :services, :sub_option

      private

      def initialize(services, sub_option)
        @services = services
        @sub_option = sub_option
      end

      def ops
        OpsClient.new(services, sub_option)
      end

      def media
        MediaClient.new(services, sub_option)
      end

      def projects
        ProjectsClient.new(services)
      end

      def di
        DistroClient.new(services, sub_option)
      end

      public

      ## Return available sections.
      def sections
        {
          media: media,
          ops: ops,
          projects: projects,
          di: di
        }
      end
    end
  end
end
