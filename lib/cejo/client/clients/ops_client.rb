# frozen_string_literal: true

require_relative '../../sections/ops/floss/core'
require_relative '../../sections/ops/homer'
require_relative '../../sections/ops/screenshot'
require_relative '../../sections/ops/volume'
require_relative '../../sections/ops/brightness'
require_relative '../../sections/ops/dots'
require_relative '../../sections/ops/sysinfo'

module Cejo
  module Client
    # Return Ops features
    class OpsClient
      attr_reader :services, :sub_option

      private

      def initialize(services, sub_option)
        @services = services
        @sub_option = sub_option
      end

      def floss
        Cejo::Ops::Floss::Core.new(services, sub_option)
      end

      def dots
        Cejo::Ops::Dots.new(services, sub_option)
      end

      def homer
        Cejo::Ops::Homer.new
      end

      def screenshot
        Cejo::Ops::Screenshot.new(services)
      end

      def volume
        Cejo::Ops::Volume.new(services, sub_option)
      end

      def brightness
        Cejo::Ops::Brightness.new(services, sub_option)
      end

      def sysinfo
        Cejo::Ops::Sysinfo.new(services, sub_option)
      end

      public

      def features
        {
          dots: dots,
          floss: floss,
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
