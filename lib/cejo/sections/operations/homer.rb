# frozen_string_literal: true

module Cejo
  module Ops
    # Symbolic link selected folders to $HOME.
    class Homer
      private

      HOME = Pathname.new(Dir.home)

      def prepare_folders
        root = Pathname.new('/data')
        new_folders = {}

        root.each_child do |folder|
          new_folders[folder] = HOME.join(folder.basename)
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
