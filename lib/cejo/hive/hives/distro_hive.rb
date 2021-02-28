# frozen_string_literal: true

module Cejo
  module Hive
    # Distro Hives
    class DistroHive
      attr_reader :folders, :utils, :arguments

      private

      def initialize(services, arguments)
        @utils = services.utils
        @folders = services.folders
        @arguments = arguments
      end

      def install
        Distro::Base.new(folders, utils, arguments, 'install')
      end

      def remove
        Distro::Base.new(folders, utils, arguments, 'remove')
      end

      def search
        Distro::Base.new(folders, utils, arguments, 'search')
      end

      def upgrade
        Distro::Base.new(folders, utils, arguments, 'upgrade')
      end

      def update
        Distro::Base.new(folders, utils, arguments, 'update')
      end

      def clean
        Distro::Base.new(folders, utils, arguments, 'clean')
      end

      def autoremove
        Distro::Base.new(folders, utils, arguments, 'autoremove')
      end

      def download
        Distro::Base.new(folders, utils, arguments, 'download')
      end

      def installed
        Distro::Base.new(folders, utils, arguments, 'installed')
      end

      def fix
        Distro::Base.new(folders, utils, arguments, 'fix')
      end

      public

      def features
        {
          i:  install,
          r:  remove,
          ug: upgrade,
          ud: update,
          c:  clean,
          s:  search,
          dw: download,
          id: installed,
          f:  fix
        }
      end
    end
  end
end
