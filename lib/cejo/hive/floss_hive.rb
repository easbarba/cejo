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
        @arguments = arguments if arguments
      end

      public

      def features
        {
          archive: Floss::Core.new(folders, utils, :archive, arguments),
          grab: Floss::Core.new(folders, utils, :grab, arguments),
        }
      end
    end
  end
end
