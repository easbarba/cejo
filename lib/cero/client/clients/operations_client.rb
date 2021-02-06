# frozen_string_literal: true

require 'sections/operations/oss'
require 'sections/operations/homer'
require 'sections/operations/screenshot'
require 'sections/operations/volume'
require 'sections/operations/brightness'
require 'sections/operations/dots'
require 'sections/operations/sysinfo'

module Cero
  module Client
    # Return Operations features
    class OperationsClient
      attr_reader :services, :subcommand

      private

      def initialize(services, subcommand)
        @services = services
        @subcommand = subcommand
      end

      def oss
        Cero::Ops::Oss.new(services, subcommand)
      end

      def dots
        Cero::Ops::Dots.new(services, subcommand)
      end

      def homer
        Cero::Ops::Homer.new
      end

      def screenshot
        Cero::Ops::Screenshot.new(services)
      end

      def volume
        Cero::Ops::Volume.new(services, subcommand)
      end

      def brightness
        Cero::Ops::Brightness.new(services, subcommand)
      end

      def sysinfo
        Cero::Ops::Sysinfo.new(services, subcommand)
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
