# frozen_string_literal: true

module Cejo
  module Hive
    # Brought to you by Flossy Vanities
    class FlossHive
      attr_reader :services, :arguments

      private

      def initialize(services, arguments)
        @services = services
        @arguments = arguments
      end

      def grab
        Floss::Core.new(services.resolve(:folders), services.resolve(:utils), :grab, arguments)
      end

      def archive
        Floss::Core.new(services.resolve(:folders), services.resolve(:utils), :archive, arguments)
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
