# frozen_string_literal: true

require 'pathname'
require 'json'
require 'uri'

module Cero
  module Ops
    # Open Source Projects utilities
    class Oss
      attr_reader :services, :git

      private

      def initialize(services)
        @services = services
        @git = services.git
      end

      def projects
        Pathname.new(File.join(Dir.home, 'Projects'))
      end

      def oss_projects
        @ossfile_path ||= services.folders.cero_config + 'oss.json'
        JSON.parse(File.read(@ossfile_path))
      end

      Data = Struct.new(:url, :name, :folder)

      def project_info(project, language)
        url = URI(project)
        name = url.path.split('/').last
        folder = projects.join(language, name)

        Data.new url, name, folder
      end

      ARCHIVE_THESE = ['cero', 'lxbarbosa.github.io', 'documentos', 'ruby',
                       'rubygems', 'rubocop', 'rails', 'emacs-async',
                       'use-package', 'lsp-mode', 'emacs'].freeze

      ## Archive desired FLOSS projects
      Archive_this = lambda do |project, git|
        return unless ARCHIVE_THESE.include?(project.name)

        archives_folder = Pathname.new(File.join(Dir.home, 'Downloads', 'projects'))
        Dir.mkdir(archives_folder) unless archives_folder.exist?

        to = archives_folder + project.name
        git.archive to, project.folder # archive thread
      end

      ## Clone FLOSS Projects
      Get_this = lambda do |project, git|
        if project.folder.exist?
          git.pull project.folder
        else
          git.clone project.url, project.folder
        end
      end

      def mapc(action)
        oss_projects.each do |language, projects|
          puts "\n--> #{language}"
          projects.each { |project| action.call(project_info(project, language), git) }
        end
      end

      public

      def archive
        mapc(Archive_this)
      end

      def get
        mapc(Get_this)
      end
    end
  end
end
