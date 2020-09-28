# frozen_string_literal: true

module Cero
  module Ops
    # Manage System brightness.
    class Brightness
      attr_reader :services, :state

      private

      def initialize(services, state)
        @services = services
        @state = state.to_sym if %w[up down].include? state
      end

      def brighter
        'brightnessctl'
      end

      def step
        5
      end

      def states
        {
          up: "set #{step}%+",
          down: "set #{step}%-"
        }
      end

      public

      def run_args
        brighter + ' ' + states[state]
      end

      def run
        system(run_args)
      end
    end
  end
end
