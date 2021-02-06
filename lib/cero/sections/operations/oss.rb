# frozen_string_literal: true

require 'pathname'
require 'json'
require 'uri'

module Cero
  module Ops
    # Open Source Projects utilities
    class Oss
      ARCHIVE_THESE = ['cero', 'lxbarbosa.github.io', 'documentos', 'ruby',
                       'rubygems', 'rubocop', 'rails', 'emacs-async',
                       'use-package', 'lsp-mode', 'emacs'].freeze

      attr_reader :services, :command

      private

      def initialize(services, command)
        @services = services
        @command =  command

        @git = services.git
        @projects = Pathname.new(File.join(Dir.home, 'Projects'))
      end

      DATA = Struct.new(:url, :name, :folder)

      # Archive desired FLOSS projects
      ARCHIVE_THIS = lambda do |project, git|
        return unless ARCHIVE_THESE.include?(project.name)

        archives_folder = Pathname.new(File.join(Dir.home, 'Downloads', 'projects'))
        Dir.mkdir(archives_folder) unless archives_folder.exist?

        to = archives_folder + project.name
        @git.archive to, project.folder # archive thread
      end

      # Clone FLOSS Projects
      GET_THIS = lambda do |project, git|
        if project.folder.exist?
          git.pull project.folder
        else
          git.clone project.url, project.folder
        end
      end

      def oss_projects
        ossfile_path ||= services.folders.cero_config.join('oss').join('oss.json')
        JSON.parse(File.read(ossfile_path))
      end

      def project_info(project, language)
        url = URI(project)
        name = url.path.split('/').last
        folder = @projects.join(language, name)

        DATA.new url, name, folder
      end

      def mapc(command)
        oss_projects.each do |language, projects|
          puts "\n--> #{language}"
          projects.each { |project| command.call(project_info(project, language), @git) }
        end
      end

      public

      def archive
        mapc(ARCHIVE_THIS)
      end

      def get
        mapc(GET_THIS)
      end

      def run
        services.utils.info_and_exit(command, 'get', 'archive')

        public_send(command)
      end
    end
  end
end
