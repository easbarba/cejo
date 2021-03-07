# frozen_string_literal: true

module Cejo
  module Hive
    # Brought to you by Flossy Vanities
    class FlossHive
      attr_reader :utils, :folders, :arguments

      private

      def initialize(services, arguments)
        @utils = services.resolve(:utils)
        @folders = services.resolve(:folders)
        @arguments = arguments
      end

      def grab
        Floss::Core.new(folders, utils, :grab, arguments)
      end

      def archive
        Floss::Core.new(folders, utils, :archive, arguments)
      end

      public

      def features
        {
          archive: archive,
          grab: grab
        }
      end
    end
  end
end
