# frozen_string_literal: true

require 'pathname'
require 'json'
require 'uri'

module Cero
  module Operations
    # Open Source Projects utilities
    class Oss
      attr_reader :projects, :oss, :git
      ## TODO: Use folders module
      def initialize(git, folders)
        @git = git
        home = Dir.home
        @projects = Pathname.new(File.join(home, 'Projects'))

        ossfile_path = folders.cero_config + 'oss.json'
        @oss = JSON.parse(File.read(ossfile_path))
      end

      def prepare(project, language, &block)
        project_url = URI(project)
        project_name = project_url.path.split('/').last
        project_folder = @projects.join(language, project_name)

        block.call(project_url, project_folder, project_name, @git)
      end

      ARCHIVE = lambda do |_, folder, name, git|
        archives_folder = Pathname.new(File.join(Dir.home, 'Downloads', 'projects'))
        Dir.mkdir(archives_folder) unless archives_folder.exist?

        archive_these = ['cero', 'lxbarbosa.github.io', 'documentos', 'ruby',
                         'rubygems', 'rubocop', 'rails', 'emacs-async',
                         'use-package', 'lsp-mode', 'emacs']

        to = archives_folder + name

        if archive_these.include?(name) # archive thread
          puts "Archiving: #{name}"
          git.archive to, folder
        end
      end

      GET = lambda do |url, folder, name, git|
        puts "Getting: #{name}"

        if folder.exist?
          git.pull folder
        else
          git.clone url, folder
        end
      end

      ## run desired action on oss projects
      def run(action)
        @oss.keys.each do |language|
          puts "\n--> #{language}"

          doing = action == 'get' ? GET : ARCHIVE
          @oss[language].each { |project| prepare(project, language, &doing) }
        end
      end
    end
  end
end