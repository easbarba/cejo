# frozen_string_literal: true

require 'pathname'
require 'json'
require 'uri'

module Cejo
  module Ops
    # Grab or Archive FLOSS Projects
    class Oss
      # Folder where Projects repositories will be stored
      PROJECTS = Pathname.new(File.join(Dir.home, 'Projects')) # TODO: Check if folder exist, create it otherwise

      # FLOSS Projects elected to be archived
      ARCHIVE_THESE = %w[cejo ruby rake rubocop rails use-package lsp-mode emacs].freeze

      # Skeleton information of projects: url, name, folder
      DATA = Struct.new(:url, :name, :folder)

      attr_reader :services
      attr_reader :command

      private

      # Archiving FLOSS project
      ARCHIVE_THIS = lambda do |project, git|
        return unless ARCHIVE_THESE.include?(project.name)

        folder.new(File.join(Dir.home, 'Downloads', 'archived'))
        Dir.mkdir(folder) unless folder.exist?

        git.archive(folder.join(project.name), project.folder) # fiber/multithread
      end

      # Cloning/Pulling FLOSS Project
      GRAB_THIS = lambda do |project, git|
        if project.folder.exist?
          git.pull(project.folder)
          return
        end

        git.clone(project.url, project.folder)
      end

      def initialize(services, command)
        @services = services
        @command =  command
      end

      # Path of file with desired FLOSS projects
      def oss_filepath
        services.folders.cejo_config.join('oss', 'oss.json') # TODO: Parse all files in oss folder
      end

      # Parse FLOSS file path
      def oss_projects_parsed
        JSON.parse(File.read(oss_filepath))
      end

      # Provide infomation of current FLOSS project
      def project_info(project, language)
        url = URI(project)
        name = url.path.split('/').last
        folder = PROJECTS.join(language, name)

        DATA.new url, name, folder
      end

      # Generate list of Projects
      def mapc(command)
        oss_projects_parsed.each do |language, projects|
          puts "\n--> #{language}"

          projects.each do |project| # TODO: avoid nested iteration
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
