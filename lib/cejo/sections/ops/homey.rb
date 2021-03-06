# frozen_string_literal: true

require 'colorize'

module Cejo
  module Ops
    # Mirror user DATA partition folders to $HOME
    class Homey
      IGNORE_THESE = ['.Trash-1000', 'lost+found']

      attr_reader :root, :target_link

      def initialize(root)
        @root = prepare_root root
      end

      private

      # Confirms if root is a folder or return w/ exeception
      def prepare_root(root)
        Pathname.new root
      end

      def find_folders
        folders_found = {}
        home = Pathname.new(Dir.home)

        exit! unless root.exist?

        root.each_child do |folder|
          next if IGNORE_THESE.include? folder.basename.to_s

          folders_found[folder.to_sym] = home.join(folder.basename)
        end

        folders_found
      end

      # Remove $HOME folders found in DATA
      def cleanup_home
        target_link.each do |_, link_name|
          link_name.unlink if link_name.exist?
        end
      end

      def symlink_folders
        target_link.each do |target, link_name|
          File.symlink(target, link_name)
        end
      end

      # def show_info
      #   print "root folder".blue, ": ", root, "\n\n"

      #   cleanup_home do |link_name|
      #     print "Warning".red, ": ", "#{link_name}".green, " folder found, removing it!", "\n"
      #   end

      #   puts

      #   symlink_folders do |target, link_name|
      #     print "#{target}".yellow, " --> ", "#{link_name}".green, "\n"
      #   end
      # end

      public

      def run
        # show_info
        target_link = find_folders
        cleanup_home
        symlink_folders
      end
    end
  end
end
