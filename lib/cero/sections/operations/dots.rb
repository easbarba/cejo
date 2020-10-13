# frozen_string_literal: true

require 'pathname'
require 'find'

module Cero
  module Ops
    # Mirror Lar files in $HOME.
    class Dots
      private

      HOME = Pathname.new(Dir.home)

      def root_files_folders
        root = Pathname.new('/dados/Pessoal/lar')
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

      # def prepare_folders
      #   Find.find(a) do |f|
      #     next if f.start_with? a.join('.git').to_path # ignore .git folder

      #     x = Pathname.new f
      #     puts x.parent.to_path
      #   end

      #   # result = {}

      #   # SOURCE_FOLDER.children.each do |f|
      #   #   next unless f.basename.to_s != '.git' && f.directory?

      #   #   x = get_name_files f
      #   #   result[x.keys.first] = x.values
      #   # end

      #   # result
      # end

      # def target_link
      #   get_name_files # TODO: require/provide one at request
      # end

      public

      def run
        root_files_folders[:folders].each { |f| puts f }
        # target_link.each do |target, link|
        #   File.symlink(target, link) if !link.exist? && target.basename.to_s != 'lost+found'
        # end
      end
    end
  end
end
