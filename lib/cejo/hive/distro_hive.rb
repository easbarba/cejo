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
          install:  Distro::Base.new(folders, utils, arguments, 'install'),
          remove:  Distro::Base.new(folders, utils, arguments, 'remove'),
          upgrade: Distro::Base.new(folders, utils, arguments, 'upgrade'),
          update: Distro::Base.new(folders, utils, arguments, 'update'),
          autoremove: Distro::Base.new(folders, utils, arguments, 'autoremove'),
          clean:  Distro::Base.new(folders, utils, arguments, 'clean'),
          search:  Distro::Base.new(folders, utils, arguments, 'search'),
          download: Distro::Base.new(folders, utils, arguments, 'download'),
          installed: Distro::Base.new(folders, utils, arguments, 'installed'),
          fix:  Distro::Base.new(folders, utils, arguments, 'fix')
        }
      end
    end
  end
end
