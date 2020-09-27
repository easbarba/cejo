# frozen_string_literal: true

require_relative '../../sections/operations/oss.rb'

module Cero
  module Client
    # Return Operations features
    class OperationsClient
      attr_reader :services, :action

      def initialize(services, action)
        @services = services
        @action = action.deq
      end

      def oss
        Cero::Operations::Oss.new(services).send(action)
      end

      def features
        {
          oss: oss
        }
      end
    end
  end
end
