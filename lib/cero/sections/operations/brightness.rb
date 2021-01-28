# frozen_string_literal: true

module Cero
  module Ops
    # Manage System brightness.
    class Brightness
      attr_reader :services, :state, :step

      STEP = 5

      def initialize(services, state)
        @services = services
        @state = state
      end

      private

      def brighter
        'brightnessctl'
      end

      def states
        {
          up: "set #{STEP}%+",
          down: "set #{STEP}%-"
        }
      end

      public

      def run_args
        "#{brighter} #{states[state]}"
      end

      def run
        @services.utils.info_and_exit(state, '+', '-')
        @state = state.to_sym if %w[up down].include? state

        system(run_args)
      end
    end
  end
end
