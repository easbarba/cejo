# frozen_string_literal: true

require 'git'
require 'tty-spinner'

require 'pathname'
require 'yaml'
require 'uri'

module Cejo
  module Ops
    # Grab or Archive FLOSS Projects
    class Floss
      # Folder where Projects repositories will be stored
      PROJECTS = Pathname.new(File.join(Dir.home, 'Projects')) # TODO: Check if folder exist, create it otherwise

      # FLOSS Projects elected to be archived
      ARCHIVE_THESE = %w[cejo ruby rake pry rails use-package lsp-mode emacs blog].freeze

      # Skeleton information of projects: url, name, folder
      DATA = Struct.new(:url, :name, :folder)

      attr_reader :services
      attr_reader :command

      private

      # Archiving FLOSS project
      ARCHIVE_THIS = lambda do |project, git|
        return unless ARCHIVE_THESE.include?(project.name)

        folder = Pathname.new(File.join(Dir.home, 'Downloads', 'archived'))
        repo = git.open(project.folder)
        fmt = 'tar'
        name = "#{folder.join(project.name)}.#{fmt}"

        Dir.mkdir(folder) unless folder.exist?

        repo.archive(repo.current_branch, name, format: fmt) # fiber/multithread
      end

      # Cloning/Pulling FLOSS Project
      GRAB_THIS = lambda do |project, git|
        if project.folder.exist?
          puts '--> Pulling'
          puts

          repo = git.open(project.folder)
          repo.pull('origin', repo.current_branch)
        else
          puts '--> Cloning'
          puts

          repo = "#{project.url}"
          git.clone(repo, project.folder)
        end
      end

      def initialize(services, command)
        @services = services
        @command =  command

        @parsed_projects = {}
      end

      # Display Project information
      def show_project_info(url, folder)
        puts "repository: #{url}"
        puts "folder: #{folder}"
        puts
      end

      # Path of file with desired FLOSS projects
      def floss_filepath
        services.folders.cejo_config.join('oss')
      end

      # Parse FLOSS file path
      def parse_oss_projects
        a = {}

        floss_filepath.each_child do |x|
          name = x.basename.sub_ext('').to_s
          a[name] = YAML.load_file x if x.extname == '.yaml'
        end

        a
      end

      # Provide infomation of current FLOSS project
      def project_info(project, language)
        url = URI.parse project
        name = File.basename(url.path.split('/').last, '.git')
        folder = PROJECTS.join(language, name)

        DATA.new(url, name, folder)
      end

      # Generate list of Projects
      def mapc(command)
        @parsed_projects = parse_oss_projects
        @parsed_projects.each do |language, projects|
          puts "\n--> #{language}"

          projects.each do |project| # TODO: avoid nested iteration
            info = project_info(project, language)

            show_project_info(info.url, info.folder)

            command.call(info, Git) # imperative call intead
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
