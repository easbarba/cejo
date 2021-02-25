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
        Ops::Floss::Core.new(services, sub_option)
      end

      def dots
        Ops::Dots.new(services, sub_option)
      end

      def homer
        Ops::Homer.new
      end

      def screenshot
        Ops::Screenshot.new(services)
      end

      def volume
        Ops::Volume.new(services, sub_option)
      end

      def brightness
        Ops::Brightness.new(services, sub_option)
      end

      def sysinfo
        Ops::Sysinfo.new(services, sub_option)
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
