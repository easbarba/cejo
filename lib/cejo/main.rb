# frozen_string_literal: true

require 'pathname'

# Build Floss Projects
module Cejo
  # Orchestrator of project building
  class Main
    attr_reader :builder

    def initialize(services, name)
      folders = services.resolve :folders
      utils = services.resolve :utils

      projects_parser = ProjectsParser.new(folders, utils, name)
      project_info = ProjectInfo.new(folders, projects_parser.project)

      @builder = Builder.new(utils, folders.local, project_info)
    end

    def run
      builder.run
    end
  end
end
