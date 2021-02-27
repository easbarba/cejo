# frozen_string_literal: true

module Cejo
  module Distro
    # Parse Configuration Folder
    class ConfigFolder
      attr_reader :services

      def initialize(services)
        @services = services
      end

      def folder
        services.folders.cejo_config.join "distro"
      end

      def any_config?
        folder.any?
      end
    end
  end
end
