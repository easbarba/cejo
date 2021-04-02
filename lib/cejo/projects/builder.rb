# frozen_string_literal: true

require 'pathname'

module Cejo
  # Build Floss Projects
  module Projects
    # Build Projects
    class Builder
      BUILD_FOLDER = File.join(Dir.home, 'Builds')

      attr_reader :cejo_config, :local_folder, :utils, :project

      def initialize(project)
        @local_folder = folders.local
        @utils = utils
        @project = project
        @root = BUILD_FOLDER.join(project.name)
      end

      def grab
        Floss::Grab.new(utils, root, project.url, project.to_s).run
      end

      def repo
        require 'git'

        Git.open project.root
      end

      def checkout_tag
        return if project.tag.empty?

        repo.checkout project.tag
       end

      def build_folder
        Pathname.new(File.join(Dir.home, 'Builds'))
      end

      def install
        Dir.chdir(root) do
          project.commands.each do |command|
            command.gsub!('{0}', local_folder.to_s)
            system command
          end
        end
      end

      # none, or exclusively these ones.
      def apply_patches
        tasks = project.patch
        return if tasks == 'none'

        patches = project_patches.children

        Dir.chdir(root) do
          project.patches.each do |patch|
            next unless tasks.include? patch.basename.to_s

            puts "Patched: #{patch.to_path}" # all
            repo.apply patch.to_path
          end
        end
      end

      def cleaning
        repo.reset_hard
        repo.checkout project.default

        Dir.chdir(root) do
          project.purge.each { |command| system command }
        end
      end

      def run
        grab
        checkout_tag
        apply_patches
        install # TODO: raise Git::GitExecuteError
        cleaning
      end
    end
  end
end
