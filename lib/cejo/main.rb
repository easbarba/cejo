# frozen_string_literal: true

require 'pathname'

module Cejo
  # Orchestrator of project building
  class Main
    attr_reader :folders, :utils, :name

    def initialize(services, name)
      @folders = services.resolve :folders
      @utils = services.resolve :utils
      @name = name
    end

    def projects_parser
      ProjectsParser.new(folders, utils, name)
    end

    def project_info
      ProjectInfo.new(folders, projects_parser.project)
    end

    def run
      builder = Builder.new(utils, folders.local, project_info)
      builder.run
    end
  end
end
