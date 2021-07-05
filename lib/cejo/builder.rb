# frozen_string_literal: true

require 'floss'

require 'pathname'

module Cejo
  # Build Projects
  class Builder
    BUILD_FOLDER = Pathname.new File.join(Dir.home, 'Builds')

    attr_reader :cejo_config, :local_folder, :utils, :project

    def initialize(local, utils, project)
      @local_folder = local
      @utils = utils
      @project = project
    end

    def grab
      Floss::Grab.new(utils, project.folder, project.url, project.to_s).run
    end

    def checkout_tag
      return if project.tag.empty?

      project.repository.checkout project.tag
    end

    def install
      Dir.chdir(project.folder) do
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

      Dir.chdir(project.folder) do
        project.patches.children.each do |patch|
          next unless tasks.include? patch.basename.to_s

          puts "Patched: #{patch.to_path}" # all
          project.repository.apply patch.to_path
        end
      end
    end

    def cleaning
      project.repository.reset_hard
      project.repository.checkout project.main_branch

      Dir.chdir(project.folder) do
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
