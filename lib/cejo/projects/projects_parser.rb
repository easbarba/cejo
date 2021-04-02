# frozen_string_literal: true

require 'pathname'

module Cejo
  # Build Floss Projects
  module Projects
    # Project Information
    class ProjectsParser
      attr_reader :main_config, :utils, :name

      def initialize(folders, utils, name)
        @main_config = folders.cejo_config
        @utils = utils
        @name = name
      end

      def folder
        main_config.join 'projects'
      end

      # Hash: All Projects information found lumped
      def projects
        utils.parse_folder(folder)
      end
      private :projects

      # Project Information (String : String)
      def wanted
        projects[name.to_sym]
      end
      private :wanted

      # Project Information (Symbol : String)
      def project
        wanted.transform_keys(&:to_sym)
      end
    end
  end
end
