# frozen_string_literal: true

require_relative '../../sections/operations/oss.rb'
require_relative '../../sections/operations/homer.rb'
require_relative '../../sections/operations/screenshot.rb'

module Cero
  module Client
    # Return Operations features
    class OperationsClient
      attr_reader :services, :action

      private

      def initialize(services, action)
        @services = services
        @action = action.nil? ? nil : action
      end

      def oss
        o = Cero::Operations::Oss.new(services)
        action == 'get' ? o.get : o.archive
      end

      def homer
        Cero::Operations::Homer.new(services).run
      end

      def screenshot
        Cero::Operations::Screenshot.new(services).run
      end

      public

      def features
        {
          oss: oss,
          homer: homer,
          screenshot: screenshot
        }
      end
    end
  end
end
