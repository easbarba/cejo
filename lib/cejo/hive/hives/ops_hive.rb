# frozen_string_literal: true

module Cejo
  module Hive
    # System operations front-end
    class OpsHive
      attr_reader :services, :arguments

      private

      def initialize(services, arguments)
        @services = services
        @arguments = arguments
      end

      def brightness
        Ops::Brightness.new(services.resolve(:utils), arguments)
      end

      def dots
        Ops::Dots.new(services.resolve(:utils), arguments)
      end

      def homey
        # Ops::Homey.new(arguments)
      end

      def screenshot
        Ops::Screenshot.new(services.resolve(:utils))
      end

      def volume
        Ops::Volume.new(services.resolve(:utils), arguments)
      end

      def sysinfo
        Ops::Sysinfo.new(services.resolve(:utils), arguments)
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
