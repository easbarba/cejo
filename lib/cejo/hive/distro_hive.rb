# frozen_string_literal: true

module Cejo
  module Hive
    # Distro Commands
    class DistroHive
      attr_reader :folders, :utils, :arguments

      private

      def initialize(services, arguments)
        @utils = services.resolve :utils
        @folders = services.resolve :folders
        @arguments = arguments
      end

      public

      def features
        {
          i:  Distro::Base.new(folders, utils, arguments, 'install'),
          r:  Distro::Base.new(folders, utils, arguments, 'remove'),
          ug: Distro::Base.new(folders, utils, arguments, 'upgrade'),
          ud: Distro::Base.new(folders, utils, arguments, 'update'),
          ar: Distro::Base.new(folders, utils, arguments, 'autoremove'),
          c:  Distro::Base.new(folders, utils, arguments, 'clean'),
          s:  Distro::Base.new(folders, utils, arguments, 'search'),
          dw: Distro::Base.new(folders, utils, arguments, 'download'),
          id: Distro::Base.new(folders, utils, arguments, 'installed'),
          f:  Distro::Base.new(folders, utils, arguments, 'fix')
        }
      end
    end
  end
end
