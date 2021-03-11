# frozen_string_literal: true

require "pathname"

module Cejo
  # Build Floss Projects
  module Projects
    # Build Projects
    class Builder
      attr_reader :folders, :utils, :project

      def initialize(folders, utils, project)
        @folders = folders
        @utils = utils
        @project = project
      end

      private

      def project_folder
        folders.cejo_config.join("projects")
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
        Floss::Grab.new(utils, root, url, self.to_s).grab_this
      end

      def tag
        project_info[:tag]
      end

      def patch
        project_info[:patch]
      end

      def checkout_tag
        return if tag.empty?

        require "git"
        repo = Git.open(root)
        repo.checkout(tag)
      end

      def commands
        project_info[:commands]
      end

      def build_folder
        Pathname.new(File.join(Dir.home, 'Builds'))
      end

      def root
        build_folder.join(project_info[:name])
      end

      def install
        Dir.chdir(root) do
          commands.each do |command|
            command.gsub!("{0}", folders.local.to_s)
            system command
          end
        end
      end

      def project_patches
        folders.cejo_config.join("patches")
                           .join(project_info[:name])
      end

      def apply_patches
        apply = 'git apply'
        patches = project_patches.children
        Dir.chdir(root) do
          patches.each { |patch| system "#{apply} #{patch.to_path}" }
        end
      end

      def purge
        project_info[:purge]
      end

      def cleaning
        Dir.chdir(root) do
          purge.each { |command| system command }
        end
      end

      public

      def to_s
        <<~EOF
        ❯ Building Project

        Name: #{project.capitalize}
        Url: #{url}
        Tag: #{tag}
        Patch: #{patch}
        Folder: #{root}
        EOF
      end

      def run
        grab

        checkout_tag

        apply_patches unless patch == 'yes'

        install

        cleaning
      end
    end
  end
end
