# frozen_string_literal: true

require_relative '../../sections/operations/oss'
require_relative '../../sections/operations/homer'
require_relative '../../sections/operations/screenshot'
require_relative '../../sections/operations/volume'
require_relative '../../sections/operations/brightness'

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
        o = Cero::Ops::Oss.new(services)
        o.get if command == 'get'
        o.archive if command == 'archive'
      end

      def homer
        Cero::Ops::Homer.new.run
      end

      def screenshot
        Cero::Ops::Screenshot.new(services).run
      end

      def volume
        Cero::Ops::Volume.new(services, command).run
      end

      def brightness
        Cero::Ops::Brightness.new(services, command).run
      end

      public

      def features
        {
          oss: oss,
          homer: homer,
          screenshot: screenshot,
          brightness: brightness,
          volume: volume
        }
      end
    end
  end
end
