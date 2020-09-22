# frozen_string_literal: true

require 'pathname'
require 'json'
require 'uri'

module Cero
  module Operations
    # Open Source Projects utilities
    class Oss
      attr_reader :projects, :git, :oss_projects, :home

      ## TODO: Use folders module
      def initialize(services)
        @git = services.git
        @home = Dir.home

        @projects = Pathname.new(File.join(home, 'Projects'))

        ossfile_path = services.folders.cero_config + 'oss.json'
        @oss_projects = JSON.parse(File.read(ossfile_path))
      end

      def prepare(project, language, &block)
        project_url = URI(project)
        project_name = project_url.path.split('/').last
        project_folder = projects.join(language, project_name)
        puts "-- #{project_name}"

        block.call(project_url, project_folder, project_name, git)
      end

      ARCHIVE = lambda do |_, folder, name, git|
        archives_folder = Pathname.new(File.join(home, 'Downloads', 'projects'))
        Dir.mkdir(archives_folder) unless archives_folder.exist?

        archive_these = ['cero', 'lxbarbosa.github.io', 'documentos', 'ruby',
                         'rubygems', 'rubocop', 'rails', 'emacs-async',
                         'use-package', 'lsp-mode', 'emacs']

        return unless archive_these.include?(name)

        to = archives_folder + name
        git.archive to, folder # archive thread
      end

      GET = lambda do |url, folder, _, git|
        if folder.exist?
          git.pull folder
        else
          git.clone url, folder
        end
      end

      def run(action)
        oss_projects.keys.each do |language|
          puts "\n--> #{language}"

          doing = action == 'get' ? GET : ARCHIVE
          oss_projects[language].each { |project| prepare(project, language, &doing) }
        end
      end
    end
  end
end
