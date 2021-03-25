# frozen_string_literal: true

module Cejo
  module Ops
    # Manage System brightness.
    class Brightness
      STEP = 5
      BRIGHTER = 'brightnessctl'

      attr_reader :state, :step

      def initialize(state)
        @state = state
      end

      def states
        {
          up: "set #{STEP}%+",
          down: "set #{STEP}%-",
        }
      end

      def action
        states[state.to_sym]
      end

      def final_command
        "#{BRIGHTER} #{action}"
      end

      def run
        @state = state.to_sym if %w[up down].include? state
        system(action)
      end
    end
  end
end
