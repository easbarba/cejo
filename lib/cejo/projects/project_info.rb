# frozen_string_literal: true

require 'pathname'

module Cejo
  # Build Floss Projects
  module Projects
    # Project Information
    class ProjectInfo
      attr_reader :info, :main_config, :local_folder, :utils

      def initialize(folders, info)
        @main_config = folders.cejo_config
        @info = info
      end

      def folder
        Pathname.new(Dir.home).join('Builds', name)
      end

      def name
        info[:name]
      end

      def url
        info[:url]
      end

      def tag
        info[:tag]
      end

      def patch
        info[:patch]
      end

      def commands
        info[:commands]
      end

      def purge
        info[:purge]
      end

      def main_branch
        info[:default]
      end

      def repository
        require 'git'

        Git.open folder
      end

      # Folder with all patches available
      def patches
        main_config.join('patches').join name
      end

      def to_s
        <<~INFO
          ❯ Building Project

          Name: #{name.capitalize}
          Url: #{url}
          Default: #{main_branch}
          Tag: #{tag}
          Patch: #{patch}
          Folder: #{folder}
        INFO
      end
    end
  end
end
