# frozen_string_literal: true

require "pathname"

module Cejo
  # Build Floss Projects
  module Projects
    # Build Projects
    class Builder
      attr_reader :folders, :utils
      attr_accessor :project

      def initialize(folders, utils)
        @folders = folders
        @utils = utils
      end

      private

      def build_folder
        Pathname.new(File.join(Dir.home, "Builds"))
      end

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
        Ops::Floss::Grab.new(utils, root, url, self.to_s).grab_this
      end

      def tag
        project_info[:tag]
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

      public

      def to_s
        <<~EOF
        ❯ Building Project

        Name: #{project.capitalize}
        Url: #{url}
        Tag: #{tag.nil? ? tag : '""'}
        Folder: #{root}
        EOF
      end

      def run
        grab

        checkout_tag

        install
      end
    end
  end
end
