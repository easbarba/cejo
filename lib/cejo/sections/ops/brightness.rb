# frozen_string_literal: true

module Cejo
  module Ops
    # Manage System brightness.
    class Brightness
      attr_reader :utils, :state, :step

      STEP = 5

      def initialize(utils, state)
        @utils = utils
        @state = state
      end

      private

      def brighter
        'brightnessctl'
      end

      def states
        {
          up: "set #{STEP}%+",
          down: "set #{STEP}%-",
        }
      end

      public

      def run_args
        "#{brighter} #{states[state]}"
      end

      def run
        utils.info_and_exit(state, '+', '-')
        @state = state.to_sym if %w[up down].include? state
        system(run_args)
      end
    end
  end
end
