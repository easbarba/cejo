# frozen_string_literal: true

require_relative 'project_info'
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
          folder = services.folders.cejo_config.join("floss")
          services.utils.parse_folder(folder)
        end

        def project_info
          ProjectInfo.new
        end

        def process_projects()
          parsed_projects.each do |language, projects|
            puts "\n-- #{language.capitalize} --\n\n"

            projects.each do |project|
              info = project_info.info(project, language.to_s)
              project_info.show_info(info.url, info.folder)

              yield(info)
            end
          end
        end

        public

        # Archive Project
        def archive
          action = Archive
          process_projects { |info| action.archive_this(info) }
        end

        # Clone/Pull Project
        def grab
          action = Grab.new(services.utils)
          process_projects { |info| action.grab_this(info.folder, info.url) }
        end

        def run
          services.utils.info_and_exit(command, "grab", "archive")

          public_send(command)
        end
      end
    end
  end
end
