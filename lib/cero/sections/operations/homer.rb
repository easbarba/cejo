# frozen_string_literal: true

module Cero
  module Ops
    # Symbolic link selected folders to $HOME.
    class Homer
      attr_reader :home

      private

      def initialize
        @home = Pathname.new(Dir.home)
      end

      def source_folders
        Pathname.new('/dados')
      end

      def prepare_folders
        new_folders = {}

        source_folders.each_child do |folder|
          new_folders[folder] = home.join(folder.basename)
        end

        new_folders
      end

      public

      def target_link
        prepare_folders # TODO: require/provide one at request
      end

      def run
        target_link.each do |target, link|
          File.symlink(target, link) if !link.exist? && target.basename.to_s != 'lost+found'
        end
      end
    end
  end
end
