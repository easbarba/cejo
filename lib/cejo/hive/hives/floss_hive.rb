# frozen_string_literal: true

module Cejo
  module Hive
    # Brought to you by Flossy Vanities
    class FlossHive
      attr_reader :services, :sub_option

      private

      def initialize(services, sub_option)
        @services = services
        @sub_option = sub_option
      end

      def grab
        Floss::Core.new(services.resolve(:folders), services.resolve(:utils), :grab, sub_option)
      end

      def archive
        Floss::Core.new(services.resolve(:folders), services.resolve(:utils), :archive, sub_option)
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
