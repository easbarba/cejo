# frozen_string_literal: true

require 'pathname'
require 'json'
require 'uri'

module Cero
  module Operations
    # Open Source Projects utilities
    class Oss
      attr_reader :projects, :git, :oss_projects

      ## TODO: Use folders module
      def initialize(services)
        @git = services.git
        @projects = Pathname.new(File.join(Dir.home, 'Projects'))

        ossfile_path = services.folders.cero_config + 'oss.json'
        @oss_projects = JSON.parse(File.read(ossfile_path))
      end

      Data = Struct.new(:url, :name, :folder)

      def info(project, language)
        url = URI(project)
        name = url.path.split('/').last
        folder = projects.join(language, name)

        Data.new url, name, folder
      end

      ARCHIVE_THESE = ['cero', 'lxbarbosa.github.io', 'documentos', 'ruby',
                       'rubygems', 'rubocop', 'rails', 'emacs-async',
                       'use-package', 'lsp-mode', 'emacs'].freeze

      def archive(project)
        archives_folder = Pathname.new(File.join(Dir.home, 'Downloads', 'projects'))
        ARCHIVE_THESE << 'a'
        Dir.mkdir(archives_folder) unless ARCHIVES_FOLDER.exist?


        return unless archive_these.include?(project.name)

        puts "-- #{project.name}"
        to = archives_folder + project.name
        git.archive to, project.folder # archive thread
      end

      def get(project)
        puts "-- #{project.name}"

        if project.folder.exist?
          git.pull project.folder
        else
          git.clone project.url, project.folder
        end
      end

      def run(action)
        oss_projects.each do |language, projects|
          puts "\n--> #{language}"
          projects.each { |project| public_send(action, info(project, language)) }
        end
      end
    end
  end
end
