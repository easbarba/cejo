# frozen_string_literal: true

require 'pathname'
require 'git'

module Cejo
  module Ops
    module Floss
      # Archive FLOSS Projects
      class Archive
        # FLOSS Projects elected to be archived
        ARCHIVE_THESE = %w[lar cejo rake pry use-package lsp-mode].freeze
        FMT = "tar"

        # Archiving FLOSS project
        def self.archive_this(project)
          pname = project.name


          return unless ARCHIVE_THESE.include?(pname) # only archive listed ones

          folder = Pathname.new(File.join(Dir.home, "Downloads", "archived"))
          Dir.mkdir(folder) unless folder.exist?

          name = "#{folder.join(pname)}.#{FMT}"

          repo = Git.open(project.folder)
          repo.archive(repo.current_branch, name, format: FMT) # fiber/multithread
        end
      end
    end
  end
end
