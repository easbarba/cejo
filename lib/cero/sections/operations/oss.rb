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

      def info(project, language)
        url = URI(project)
        name = url.path.split('/').last
        folder = projects.join(language, name)

        data = Struct.new(:url, :name, :folder)
        data.new url, name, folder
      end

      def archive_it(project)
        archives_folder = Pathname.new(File.join(Dir.home, 'Downloads', 'projects'))
        Dir.mkdir(archives_folder) unless archives_folder.exist?

        archive_these = ['cero', 'lxbarbosa.github.io', 'documentos', 'ruby',
                         'rubygems', 'rubocop', 'rails', 'emacs-async',
                         'use-package', 'lsp-mode', 'emacs']

        return unless archive_these.include?(project.name)

        puts "-- #{project.name}"
        to = archives_folder + project.name
        git.archive to, project.folder # archive thread
      end

      def get_it(project)
        puts "-- #{project.name}"

        if project.folder.exist?
          git.pull project.folder
        else
          git.clone project.url, project.folder
        end
      end

      def archive
        oss_projects.keys.each do |language|
          puts "\n--> #{language}"
          oss_projects[language].each { |project| archive_it(info(project, language)) }
        end
      end

      def get
        oss_projects.keys.each do |language|
          puts "\n--> #{language}"
          oss_projects[language].each { |project| get_it(info(project, language)) }
        end
      end
    end
  end
end
