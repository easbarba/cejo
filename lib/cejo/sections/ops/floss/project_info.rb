# frozen_string_literal: true

require 'pathname'
require 'uri'

module Cejo
  module Ops
    module Floss
      # Provides Project Information
      class ProjectInfo
        # Skeleton information of projects: url, name, folder
        DATA = Struct.new(:url, :name, :folder)

        # Folder where Projects repositories will be stored
        PROJECTS = Pathname.new(File.join(Dir.home, "Projects")) # TODO: Check if folder exist, create it otherwise

        # Provide infomation of current FLOSS project
        def project_info(project, language)
          url = URI.parse project
          name = File.basename(url.path.split("/").last, ".git")
          folder = PROJECTS.join(language, name)

          DATA.new(url, name, folder)
        end

        # Display Project information
        def show_project_info(url, folder)
          print "repository: ".red.bold, url, "\n"
          print "folder: ".blue.bold, folder
        end
      end
    end
  end
end
