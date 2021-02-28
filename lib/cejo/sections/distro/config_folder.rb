# frozen_string_literal: true

module Cejo
  module Distro
    # Parse Configuration Folder
    class ConfigFolder
      attr_reader :cfg_folder

      def initialize(cfg_folder)
        @cfg_folder = cfg_folder
      end

      def folder
        cfg_folder.join "distro"
      end

      def any_config?
        folder.any?
      end
    end
  end
end
