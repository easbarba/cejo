# frozen_string_literal: true

require 'pathname'
require 'json'
require 'uri'

module Cejo
  module Ops
    # Grab or Archive FLOSS Projects
    class Oss
      # FLOSS Projects elected to be archived
      ARCHIVE_THESE = %w[cejo ruby rake rubocop rails use-package lsp-mode emacs].freeze

      # Skeleton information of projects: url, name, folder
      DATA = Struct.new(:url, :name, :folder)

      attr_reader :services
      attr_reader :command

      private

      # Archive FLOSS project
      ARCHIVE_THIS = lambda do |project, git|
        return unless ARCHIVE_THESE.include?(project.name)

        archives_folder = Pathname.new(File.join(Dir.home, 'Downloads', 'projects'))
        Dir.mkdir(archives_folder) unless archives_folder.exist?

        to = archives_folder + project.name
        git.archive to, project.folder # archive thread
      end

      # Clone/Pull FLOSS Project
      GRAB_THIS = lambda do |project, git|
        git.pull(project.folder) if project.folder.exist?

        git.clone(project.url, project.folder) unless project.folder.exist?
      end

      def initialize(services, command)
        @services = services
        @command =  command
      end

      # Folder where Projects will be stored
      def projects # TODO: Check if folder exist, create it otherwise
        Pathname.new(File.join(Dir.home, 'Projects'))
      end

      # Path of file with desired FLOSS projects
      def oss_filepath
        services.folders.cejo_config.join('oss', 'oss.json')
      end

      # Parse FLOSS file path
      def oss_projects_parsed
        JSON.parse(File.read(oss_filepath))
      end

      # Provide Infomation of current FLOSS project
      def project_info(project, language)
        url = URI(project)
        name = url.path.split('/').last
        folder = projects.join(language, name)

        DATA.new url, name, folder
      end

      # Generate list of Projects
      def mapc(command)
        oss_projects_parsed.each do |language, projects|
          puts "\n--> #{language}"
          projects.each do |project|
            command.call(project_info(project, language), @services.git)
          end
        end
      end

      public

      # Archive Project
      def archive
        mapc(ARCHIVE_THIS)
      end

      # Clone/Pull Project
      def grab
        mapc(GRAB_THIS)
      end

      def run
        services.utils.info_and_exit(command, 'grab', 'archive')

        public_send(command)
      end
    end
  end
end
