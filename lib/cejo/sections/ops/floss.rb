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

      # Provide infomation of current FLOSS project
      def self.project_info(project, language)
        url = URI.parse project
        name = File.basename(url.path.split('/').last, '.git')
        folder = PROJECTS.join(language, name)

        DATA.new(url, name, folder)
      end

      # Archiving FLOSS project
      def self.archive_this(project)
        pname = project.name
        fmt = 'tar'

        return unless ARCHIVE_THESE.include?(pname) # only archive listed ones

        folder = Pathname.new(File.join(Dir.home, 'Downloads', 'archived'))
        Dir.mkdir(folder) unless folder.exist?

        name = "#{folder.join(pname)}.#{fmt}"

        repo = Git.open(project.folder)
        repo.archive(repo.current_branch, name, format: fmt) # fiber/multithread
      end

      def do_pull(folder)
        loading('Pulling') do
          repo = Git.open(folder)
          repo.pull('origin', repo.current_branch)
        end
      end

      def do_clone(url, folder)
        loading('Cloning') { Git.clone(url, folder) }
      end

      # Cloning/Pulling FLOSS Project
      def grab_this(project)
        folder = project.folder
        url = project.url

        if folder.exist?
          do_pull folder
        else
          do_clone url, folder
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

      # Files with list of FLOSS projects
      def floss_files
        services.folders.cejo_config.join('floss')
      end

      # Parse FLOSS files
      def parse_floss_projects
        projects = {}

        floss_files.each_child do |file|
          name = file.basename.sub_ext('').to_s
          projects[name] = YAML.load_file file
        end

        projects
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
        services.utils.info_and_exit(command, 'grab', 'archive')

        public_send(command)
      end
    end
  end
end
