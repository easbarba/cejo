# frozen_string_literal: true

module Cejo
  module Ops
    # Symbolic link selected folders to $HOME.
    class Homey
      IGNORE_THESE = ['.Trash-1000', 'lost+found']

      attr_reader :root, :target_link

      def initialize(root)
        @root = prepare_root root
        @target_link = {}
      end

      private

      # Confirms if root is a folder or return w/ exeception
      def prepare_root(root)
        puts "root: #{root}"
        Pathname.new root
      end

      def prepare_folders
        home = Pathname.new(Dir.home)
        root.each_child do |folder|
          target_link[folder] = home.join(folder.basename)
        end
      end

      public

      def clean_this folder
        folder.unlink if folder.exist?
      end

      def symlink_these
        target_link.each do |target, link_name|
          next if IGNORE_THESE.include? target.basename.to_s

          clean_this(link_name)

          puts "#{target} -->  #{link_name}"
          File.symlink(target, link_name)
        end
      end

      def run
        prepare_folders
        symlink_these
      end
    end
  end
end
