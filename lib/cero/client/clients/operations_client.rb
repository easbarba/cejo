# frozen_string_literal: true

require_relative '../../sections/operations/oss.rb'
require_relative '../../sections/operations/homer.rb'
require_relative '../../sections/operations/screenshot.rb'
require_relative '../../sections/operations/volume.rb'
require_relative '../../sections/operations/brightness.rb'

module Cero
  module Client
    # Return Operations features
    class OperationsClient
      attr_reader :services, :action

      private

      def initialize(services, action)
        @services = services
        @action = action
      end

      def oss
        o = Cero::Ops::Oss.new(services)
        o.get if action == 'get'
        o.archive if action == 'archive'
      end

      def homer
        Cero::Ops::Homer.new.run
      end

      def screenshot
        Cero::Ops::Screenshot.new(services).run
      end

      def volume
        Cero::Ops::Volume.new(services, action).run
      end

      def brightness
        Cero::Ops::Brightness.new(services, action).run
      end

      public

      def features
        {
          oss: oss,
          homer: homer,
          screenshot: screenshot,
          volume: volume,
          brightness: brightness
        }
      end
    end
  end
end
