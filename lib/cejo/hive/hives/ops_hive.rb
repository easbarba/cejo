# frozen_string_literal: true

module Cejo
  module Hive
    # System operations front-end
    class OpsHive
      attr_reader :argument, :utils

      private

      def initialize(services, argument)
        @utils = services.resolve(:utils)
        @argument = argument.nil? ? '' : argument[0]
      end

      def brightness
        Ops::Brightness.new(utils, argument)
      end

      def dots
        Ops::Dots.new(utils, argument)
      end

      def homey
        Ops::Homey.new(argument)
      end

      def screenshot
        Ops::Screenshot.new(utils)
      end

      def volume
        Ops::Volume.new(utils, argument)
      end

      def sysinfo
        Ops::Sysinfo.new(utils, argument)
      end

      public

      def features
        {
          brightness: brightness,
          dots: dots,
          volume: volume,
          screenshot: screenshot,
          sysinfo: sysinfo,
          homey: homey
        }
      end
    end
  end
end
