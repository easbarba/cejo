# frozen_string_literal: true

require 'pathname'

module Cejo
  # Manage FLOSS Projects
  module Floss
    # Core Management FLOSS Projects
    class Core
      attr_reader :services, :folders, :utils
      attr_reader :command, :sub_command

      def initialize(folders, utils, command, sub_command)
        @folders = folders
        @utils = utils
        @command = command
        @sub_command = sub_command
      end

      def parsed_projects
        folder = folders.cejo_config.join('floss')
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
          Grab.new(utils, info.folder, info.url, info.to_s).grab_this
        end
      end

      def run
        utils.info_and_exit(command, 'grab', 'archive') if command.nil?
        if command == :archive
          archive
        end
        if command == :grab
          grab
        end
      end
    end
  end
end
