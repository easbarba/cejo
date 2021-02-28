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

        def process_projects()
          parsed_projects.each do |language, projects|
            print <<~EOF

            ❯ #{language.capitalize}

            EOF

            projects.each do |url|
              info = ProjectInfo.new(url, language.to_s)
              yield(info)
            end
          end
        end

        public

        def archive
          process_projects do |info|
            Archive.new(utils).archive_this(info.name, info.folder, info.to_s)
          end
        end

        def grab
          process_projects do |info|
            Grab.new(utils, info.folder, info.url, info.to_s)
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
