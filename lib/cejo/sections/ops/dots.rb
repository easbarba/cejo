# frozen_string_literal: true

require 'colorize'

require 'pathname'
require 'find'

module Cejo::Ops
  # Mirror Lar files in $HOME.
  class Dots
    attr_reader :root, :ignore_these, :utils, :home

    private

    def initialize(utils, root)
      @utils = utils
      @root = Pathname.new root
      @home = Pathname.new(Dir.home)
    end

    def root_files_folders
      files = []
      folders = []

      Find.find(root) do |file|
        filepath = Pathname.new file

        next if filepath == root
        next if file.start_with? root.join('.git').to_path.to_s

        files << filepath if filepath.file?
        folders << filepath if filepath.directory?
      end

      { folders: folders, files: files }
    end

    # transform origin file absolute path with home as its root instead
    # /a/b/c.tar --> /home/b/c.tar
    def to_home(this)
      origin = this.to_path
      homey = home.to_path.concat('/')
      result = origin.gsub(root.to_path, homey)
      result = Pathname.new(result)
    end

    # Create only the folders, if those do not exist
    def create_folders
      root_files_folders[:folders].each do |f|
        folder = to_home f
        next if folder.exist?

        puts folder
        folder.mkdir
      end
    end

    # Move file from home to a /home/backup/{file}
    # or delete it if the file it is pointing does not exist
    def backup_this(this)
      puts
      print "WARNING".red, ": Deleting or moving #{this}"
      puts

      this.delete if this.exist?  # TODO: if file exist back/delete up it
    end

    def symlink_files
      root_files_folders[:files].each do |target|
        next if ignored_ones.include? target.basename.to_s
        symlink_name = to_home target

        backup_this symlink_name

        # TODO: Extract this to use in a block
        # TODO: Symlink only if not exist or symlkin point to nowhere
        print "#{target}".yellow, " ❯ ", "#{symlink_name}".green
        puts

        symlink_name.make_symlink target # As enumerator yielding folder to symlink
      end
    end
    #
    def ignored_ones
      ['LICENSE', root.join('.git').to_path.to_s].freeze
    end

    public

    def run
      utils.info_and_exit(root, '/path/to/folder')

      create_folders
      symlink_files
    end
  end
end
