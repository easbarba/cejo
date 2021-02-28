# frozen_string_literal: true

require 'pathname'

module Cejo
  module Ops
    module Floss
      # Archive FLOSS Projects
      class Archive
        attr_reader :utils, :filename, :project_folder

        # FLOSS Projects elected to be archived
        ARCHIVE_THESE = %w[lar cejo rake pry use-package lsp-mode].freeze

        # Format to be compressed
        FMT = "tar"

        # Folder which compressed files will be stored
        STORE_FOLDER = Pathname.new(File.join(Dir.home, "Downloads", "archived"))

        def initialize(utils)
          @utils = utils
        end

        # Archiving FLOSS project
        def archive_this(project)
          name = project.name
          @filename = "#{STORE_FOLDER.join(name)}.#{FMT}"
          @project_folder = project.folder

          return unless ARCHIVE_THESE.include?(name) # only archive listed ones
          puts project.to_s

          mk_folder
          do_archive
        end

        def mk_folder
          Dir.mkdir(STORE_FOLDER) unless STORE_FOLDER.exist?
        end

        def do_archive
          require 'git'
          utils.spin('Archiving') do
            repo = Git.open(project_folder)
            repo.archive(repo.current_branch, filename, format: FMT) # fiber/multithread
          end
        end
      end
    end
  end
end
