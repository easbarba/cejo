# frozen_string_literal: true

require 'git'

require "pathname"

module Cejo
  # Build Floss Projects
  module Projects
    # Projects Core Information
    class Core
      attr_reader :services, :project

      def initialize(services, project)
        @services = services
        @project = project.to_sym
      end

      def build_folder
        folder = Pathname.new(File.join(Dir.home, "Builds"))
        folder.mkdir unless folder.exist?
        folder
      end

      def root
        build_folder.join(project_info[:name])
      end

      def grab
        g = Cejo::Ops::Floss::Grab.new(services.utils)
        url = project_info[:url]

        g.grab_this(root, url)
      end

      private

      def project_info
        folder = services.folders.cejo_config.join("projects")
        result = services.utils.parse_folder(folder)[project]

        result.transform_keys(&:to_sym)
      end

      def check_tag
        tag = project_info[:tag]

        return if tag.empty?

        repo = Git.open(root)
        repo.checkout(tag)
      end

      def install
        install_folder = Pathname.new(File.join(Dir.home, '.local')).to_s

        Dir.chdir(root) do
          project_info[:commands].each do |x|
            x.gsub!('{0}', install_folder)
            system x
          end
        end
      end

      public

      def run()
        build_folder
        grab
        check_tag
        install
      end
    end
  end
end
