# frozen_string_literal: true

require 'pathname'

module Cejo
  module Floss
    # Archive FLOSS Projects
    class Archive
      # FLOSS Projects elected to be archived
      ARCHIVE_THESE = %w[lar distro cejo ixi gota].freeze

      # Format to be compressed
      FMT = 'tar'

      # Folder which compressed files will be stored
      ARCHIVED_FOLDER = Pathname.new(File.join(Dir.home, 'Downloads', 'archived'))

      attr_reader :utils, :archived_filename, :name, :folder, :info

      def initialize(utils, name, folder, info)
        @utils = utils
        @name = name
        @folder = folder
        @info = info
        @archived_filename = "#{ARCHIVED_FOLDER.join(name)}.#{FMT}"
      end

      # Archiving FLOSS project
      def do_archive
        require 'git'

        utils.spin('Archiving') do
          repo = Git.open folder
          repo.archive repo.current_branch, archived_filename, format: FMT # TODO: fiber/multithread
        end
        puts
      end

      def run
        return unless ARCHIVE_THESE.include? name

        Dir.mkdir ARCHIVED_FOLDER unless ARCHIVED_FOLDER.exist?

        print info
        do_archive
      end
    end
  end
end
