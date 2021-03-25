# frozen_string_literal: true

require 'pathname'

module Cejo
  # Build Floss Projects
  module Projects
    # Build Projects
    class Builder
      attr_reader :cejo_config, :local_folder, :utils, :project

      def initialize(folders, utils, project)
        @cejo_config = folders.cejo_config
        @local_folder = folders.local
        @utils = utils
        @project = project
      end

      def project_folder
        cejo_config.join('projects')
      end

      def project_info
        utils.parse_folder(project_folder)[project.to_sym]
           .transform_keys(&:to_sym)
      end

      def url
        project_info[:url]
      end

      def root
        build_folder.join(project_info[:name])
      end

      def grab
        Floss::Grab.new(utils, root, url, self.show_info).run
      end

      def tag
        project_info[:tag]
      end

      def patch
        project_info[:patch]
      end

      def repo
        require 'git'
        Git.open(root)
      end

      def checkout_tag
        return if tag.empty?
        repo.checkout(tag)
      end

      def commands
        project_info[:commands]
      end

      def build_folder
        Pathname.new(File.join(Dir.home, 'Builds'))
      end

      def install
        Dir.chdir(root) do
          commands.each do |command|
            command.gsub!('{0}', local_folder.to_s)
            system command
          end
        end
      end

      def project_patches
        cejo_config.join('patches')
                .join(project_info[:name])
      end

      # none, or exclusively these ones.
      def apply_patches
        tasks = project_info[:patch]
        return if tasks == 'none'

        patches = project_patches.children

        Dir.chdir(root) do
          patches.each do |patch|
            next unless tasks.include? patch.basename.to_s
            puts "Patched: #{patch.to_path}" # all
            repo.apply patch.to_path
          end
        end
      end

      def purge
        project_info[:purge]
      end

      def default
        project_info[:default]
      end

      def cleaning
        repo.reset_hard
        repo.checkout default

        Dir.chdir(root) do
          purge.each { |command| system command }
        end
      end

      public

      def show_info
        <<~EOF
          ❯ Building Project

          Name: #{project.capitalize}
          Url: #{url}
          Default: #{default}
          Tag: #{tag}
          Patch: #{patch}
          Folder: #{root}
        EOF
      end
      alias to_s show_info

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
