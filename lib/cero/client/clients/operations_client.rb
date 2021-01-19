# frozen_string_literal: true

require_relative '../../sections/operations/oss'
require_relative '../../sections/operations/homer'
require_relative '../../sections/operations/screenshot'
require_relative '../../sections/operations/volume'
require_relative '../../sections/operations/brightness'
require_relative '../../sections/operations/dots'
require_relative '../../sections/operations/sysinfo'

module Cero
  module Client
    # Return Operations features
    class OperationsClient
      attr_reader :services, :command

      private

      def initialize(services, command)
        @services = services
        @command = command
      end

      def oss
        Cero::Ops::Oss.new(services, command)
      end

      def dots
        Cero::Ops::Dots.new(command)
      end

      def homer
        Cero::Ops::Homer.new
      end

      def screenshot
        Cero::Ops::Screenshot.new(services)
      end

      def volume
        Cero::Ops::Volume.new(services, command)
      end

      def brightness
        Cero::Ops::Brightness.new(services, command)
      end

      def sysinfo
        Cero::Ops::Sysinfo.new(services, command)
      end

      public

      def features
        {
          dots: dots,
          oss: oss,
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
