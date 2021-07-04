# frozen_string_literal: true

require 'pathname'

module Cejo
  module Projects
    # Orchestrator of project building
    class Main
      attr_reader :builder

      def initialize(services, name)
        folders = services.resolve(:folders)
        utils = services.resolve(:utils)
        projects_parser = ProjectsParser.new(folders, utils, name)
        project_info = ProjectInfo.new(folders, projects_parser.project)

        @builder = Builder.new folders.local, utils, project_info
      end

      def run
        builder.run
      end
    end
  end
end
