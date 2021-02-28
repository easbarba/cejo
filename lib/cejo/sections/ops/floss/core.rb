# frozen_string_literal: true

require_relative 'project_info'
require_relative 'archive'
require_relative 'grab'

require "pathname"

module Cejo
  module Ops
    # Manage FLOSS Projects
    module Floss
      # Core Management FLOSS Projects
      class Core
        attr_reader :services, :folders, :utils
        attr_reader :command

        private

        def initialize(services, command = 'grab')
          @folders = services.folders
          @utils = services.utils
          @command = command
        end

        def parsed_projects
          folder = folders.cejo_config.join("floss")
          utils.parse_folder(folder)
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

        def archive
          process_projects { |info| Archive.archive_this(info) }
        end

        def grab
          process_projects do |info|
            Grab.new(utils, info.folder, info.url)
                .grab_this
          end
        end

        def run
          utils.info_and_exit(command, "grab", "archive")

          public_send(command)
        end
      end
    end
  end
end
