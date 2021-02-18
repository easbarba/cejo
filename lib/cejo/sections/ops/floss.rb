# frozen_string_literal: true

require 'git'
require 'tty-spinner'
require 'colorize'

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
      ARCHIVE_THESE = %w[lar cejo rake pry use-package lsp-mode].freeze

      # Skeleton information of projects: url, name, folder
      DATA = Struct.new(:url, :name, :folder)

      attr_reader :services
      attr_reader :command

      private

      def initialize(services, command)
        @services = services
        @command =  command

        @parsed_projects = {}
      end

      # Archiving FLOSS project
      def archive_this(project)
        return unless ARCHIVE_THESE.include?(project.name) # only archive listed ones

        folder = Pathname.new(File.join(Dir.home, 'Downloads', 'archived'))
        Dir.mkdir(folder) unless folder.exist?

        name = "#{folder.join(project.name)}.tar"
        repo = Git.open(project.folder)
        repo.archive(repo.current_branch, name, format: fmt) # fiber/multithread
      end

      # Cloning/Pulling FLOSS Project
      def grab_this(project)
        if project.folder.exist?
          loading('Pulling') do
            repo = Git.open(project.folder)
            repo.pull('origin', repo.current_branch)
          end
        else
          loading('Cloning') { Git.clone(project.url, project.folder) }
        end
      end

      def loading(msg)
        spinner = TTY::Spinner.new(":spinner #{msg}", format: :dots_6)

        puts
        spinner.auto_spin

        yield

        spinner.stop('Done!')
        puts
      end

      # Display Project information
      def show_project_info(url, folder)
        print "repository: ".red.bold, url, "\n"
        print "folder: ".blue.bold, folder
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
      def mapc
        parse_oss_projects.each do |language, projects|
          puts "\n-- #{language.capitalize} --\n\n"

          projects.each do |project| # TODO: avoid nested iteration
            info = project_info(project, language)

            show_project_info(info.url, info.folder)

            yield(info)
          end
        end
      end

      public

      # Archive Project
      def archive
        mapc() { |info| archive_this(info) }
      end

      # Clone/Pull Project
      def grab
        mapc() { |info| grab_this(info) }
      end

      def run
        services.utils.info_and_exit(command, 'grab', 'archive')

        public_send(command)
      end
    end
  end
end
