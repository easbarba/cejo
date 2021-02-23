# frozen_string_literal: true

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

          @parsed_projects = {}
        end

        # Generate list of Projects
        def lang_projects
          parse_floss_projects.each do |language, projects|
            puts "\n-- #{language.capitalize} --\n\n"

            yield(language, projects)
          end
        end

        def process_projects
          lang_projects do |language, projects|
            projects.each do |project|
              info = Floss.project_info(project, language)

              show_project_info(info.url, info.folder)

              yield(info)
            end
          end
        end

        public

        # Archive Project
        def archive
          process_projects { |info| Floss.archive_this(info) }
        end

        # Clone/Pull Project
        def grab
          process_projects { |info| grab_this(info) }
        end

        def run
          services.utils.info_and_exit(command, "grab", "archive")

          public_send(command)
        end
      end
    end
  end
end
