# frozen_string_literal: true

module Cejo
  module Distro
    # Parse Configuration Folder
    class ConfigFolder
      attr_reader :services

      private

      def initialize(services)
        @services = services
      end

      def any_config?
        folder.any?
      end

      def folder
        services.folders.cejo_config.join 'distro'
      end

      def raw_commands
        services.utils.parse_folder folder
      end
    end
  end
end
