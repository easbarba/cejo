# frozen_string_literal: true

require 'pathname'

module Cejo
  # Manage FLOSS Projects
  module Floss
    # Core Management FLOSS Projects
    class Core
      attr_reader :services, :folders, :utils, :command

      def initialize(folders, utils, command)
        @folders = folders
        @utils = utils
        @command = command
      end

      def parsed_projects
        folder = folders.cejo_config.join('floss')
        utils.parse_folder(folder)
      end

      def process_projects
        parsed_projects.each do |language, projects|
          puts "\n❯ #{language.capitalize}"
          puts

          projects.each do |url|
            project_info = ProjectInfo.new(url, language.to_s)
            yield(project_info)
          end
        end
      end

      def archive
        process_projects do |info|
          Archive.new(utils, info.name, info.folder, info.to_s).run
        end
      end
      public :archive

      def grab
        process_projects do |info|
          Grab.new(utils, info.folder, info.url, info.to_s).run
        end
      end
      public :grab

      def run
        public_send(command)
      end
      public :run
    end
  end
end
