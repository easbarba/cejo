# frozen_string_literal: true

require_relative '../../sections/operations/floss'
require_relative '../../sections/operations/homer'
require_relative '../../sections/operations/screenshot'
require_relative '../../sections/operations/volume'
require_relative '../../sections/operations/brightness'
require_relative '../../sections/operations/dots'
require_relative '../../sections/operations/sysinfo'

module Cejo
  module Client
    # Return Operations features
    class OperationsClient
      attr_reader :services, :subcommand

      private

      def initialize(services, subcommand)
        @services = services
        @subcommand = subcommand
      end

      def floss
        Cejo::Ops::Floss.new(services, subcommand)
      end

      def dots
        Cejo::Ops::Dots.new(services, subcommand)
      end

      def homer
        Cejo::Ops::Homer.new
      end

      def screenshot
        Cejo::Ops::Screenshot.new(services)
      end

      def volume
        Cejo::Ops::Volume.new(services, subcommand)
      end

      def brightness
        Cejo::Ops::Brightness.new(services, subcommand)
      end

      def sysinfo
        Cejo::Ops::Sysinfo.new(services, subcommand)
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
