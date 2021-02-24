# frozen_string_literal: true

require 'pathname'
require 'find'

module Cejo::Ops
  # Mirror Lar files in $HOME.
  class Dots
    attr_reader :root, :ignore_these

    HOME = Pathname.new(Dir.home)

    private

    def initialize(services, root)
      @services = services
      @root = root
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

    def to_home(this)
      origin = this.to_path
      homey = HOME.to_path.concat('/')
      result = origin.gsub(root.to_path, homey)

      Pathname.new(result)
    end

    def create_home_folders
      root_files_folders[:folders].each do |f|
        folder = to_home f
        next if folder.exist?

        puts folder
        folder.mkdir
      end
    end

    def backup_this(this)
      puts "Deleting or Moving: #{this}"
      this.delete if this.exist?  # TODO: if file exist back/delete up it
    end

    def symlink_files # TODO: As enumerator yielding folder to symlink
      root_files_folders[:files].each do |target|
        next if ignore_these.include? target.basename.to_s

        symlink_name = to_home target

        backup_this symlink_name

        # TODO: Extract this to use in a block
        # TODO: Symlink only if not exist or symlkin point to nowhere
        puts "#{target} --> #{symlink_name}"
        symlink_name.make_symlink target
      end
    end

    public

    def run
      @services.utils.info_and_exit(root, '/path/to/folder')
      @root = Pathname.new(root) # TODO: check if is a folder
      @ignore_these = ['LICENSE', root.join('.git').to_path.to_s].freeze

      create_home_folders
      symlink_files
    end
  end
end
