# frozen_string_literal: true

module Cejo
  module Hive
    # Return Ops features
    class OpsHive
      attr_reader :services, :sub_option

      private

      def initialize(services, sub_option)
        @services = services
        @sub_option = sub_option
      end

      def dots
        Ops::Dots.new(services.resolve(:utils), sub_option)
      end

      def homer
        Ops::Homer.new
      end

      def screenshot
        Ops::Screenshot.new(services.resolve(:utils))
      end

      def volume
        Ops::Volume.new(services.resolve(:utils), sub_option)
      end

      def brightness
        Ops::Brightness.new(services.resolve(:utils), sub_option)
      end

      def sysinfo
        Ops::Sysinfo.new(services.resolve(:utils), sub_option)
      end

      public

      def features
        {
          dots: dots,
          homer: homer,
          screenshot: screenshot,
          brightness: brightness,
          volume: volume,
          sysinfo: sysinfo
        }
      end
    end
  end
end
