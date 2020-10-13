# frozen_string_literal: true

require 'pathname'
require 'find'

module Cero
  module Ops
    # Mirror Lar files in $HOME.
    class Dots
      private

      HOME = Pathname.new(Dir.home)
      ROOT = Pathname.new('/dados/Pessoal/lar')
      IGNORE = ['LICENSE', ROOT.join('.git').to_path.to_s].freeze

      def root_files_folders
        files = []
        folders = []

        Find.find(ROOT) do |file|
          filepath = Pathname.new file

          next if filepath == ROOT
          next if file.start_with? ROOT.join('.git').to_path.to_s

          files << filepath if filepath.file?
          folders << filepath if filepath.directory?
        end

        { folders: folders, files: files }
      end

      def to_home(this)
        Pathname.new(this.to_path.gsub(ROOT.to_path, HOME.to_path))
      end

      def create_home_folders
        root_files_folders[:folders].each do |f|
          folder = to_home f
          next if folder.exist?

          puts folder
          folder.mkdir
        end
      end

      # def backup_this(this)
      #   # next if this.symlink?

      #   backup = Pathname.new HOME.join('backup')
      #   p backup
      # end

      def symlink_files
        root_files_folders[:files].each do |f|
          next if IGNORE.include? f.basename.to_s

          file = to_home f

          file.delete if file.exist?

          puts "#{f} --> #{file}"
          file.make_symlink f
        end
      end

      public

      def run
        create_home_folders
        symlink_files
      end
    end
  end
end
