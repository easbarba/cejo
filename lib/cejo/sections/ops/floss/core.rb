# frozen_string_literal: true

require_relative 'project_info'
require_relative 'parsed_projects'
require_relative 'archive'
require_relative 'grab'

require "colorize"

require "pathname"

module Cejo
  module Ops
    # Manage FLOSS Projects
    module Floss
      # Core Management FLOSS Projects
      class Core
        attr_reader :services
        attr_reader :command

        private

        def initialize(services, command = 'grab')
          @services = services
          @command = command
        end

        def parsed_projects
          folder = services.folders.cejo_config
          Cejo::Ops::Floss::Parsed_Projects.new(folder).parse_floss_projects
        end

        # Generate list of Projects
        def lang_projects
          parsed_projects.each do |language, projects|
            puts "\n-- #{language.capitalize} --\n\n"

            yield(language, projects)
          end
        end

        def process_projects
          proj = Cejo::Ops::Floss::ProjectInfo.new
          lang_projects do |language, projects|
            projects.each do |project|
              info = proj.project_info(project, language)

              proj.show_project_info(info.url, info.folder)

              yield(info)
            end
          end
        end

        public

        # Archive Project
        def archive
          arc = Cejo::Ops::Floss::Archive
          process_projects { |info| arc.archive_this(info) }
        end

        # Clone/Pull Project
        def grab
          grb = Cejo::Ops::Floss::Grab.new(services.utils)
          process_projects { |info| grb.grab_this(info) }
        end

        def run
          services.utils.info_and_exit(command, "grab", "archive")

          public_send(command)
        end
      end
    end
  end
end
