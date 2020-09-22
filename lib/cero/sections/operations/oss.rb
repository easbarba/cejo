# frozen_string_literal: true

require 'pathname'
require 'json'
require 'uri'

module Cero
  module Operations
    # Open Source Projects utilities
    class Oss
      attr_reader :projects, :git, :oss_projects, :data

      ## TODO: Use folders module
      def initialize(services)
        @git = services.git
        @projects = Pathname.new(File.join(Dir.home, 'Projects'))
        @data = Struct.new(:url, :name, :folder)

        ossfile_path = services.folders.cero_config + 'oss.json'
        @oss_projects = JSON.parse(File.read(ossfile_path))
      end

      def prepare(project, language, &block)
        url = URI(project)
        name = url.path.split('/').last
        folder = projects.join(language, name)

        project = data.new url, name, folder
        block.call(project, git)
      end

      ARCHIVE = lambda do |project, git|
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

      GET = lambda do |project, git|
        puts "-- #{project.name}"

        if project.folder.exist?
          git.pull project.folder
        else
          git.clone project.url, project.folder
        end
      end

      def run(action)
        oss_projects.keys.each do |language|
          puts "\n--> #{language}"
          oss_projects[language].each { |project| prepare(project, language, &action) }
        end
      end

      def get
        run(GET)
      end

      def archive
        run(ARCHIVE)
      end
    end
  end
end
