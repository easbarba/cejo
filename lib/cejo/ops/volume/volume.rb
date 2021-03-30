# frozen_string_literal: true

module Cejo
  module Ops
    # Manage System Volume.
    class Volume
      STEP = 3

      attr_reader :state
      attr_accessor :info

      def initialize(utils, state)
        @state = state.to_sym if state
        @info = SoundManager.new(utils).info
      end

      def states
        {
          up: '+',
          down: '-',
          toggle: ''
        }
      end

      # * PACTL

      def pactl
        {
          name: 'pactl',
          toggle: "set-sink-mute #{info.sink} toggle",
          updown: "set-sink-volume #{info.sink} #{states[state]}#{STEP}%"
        }
      end

      def pactl_toggle
        [pactl[:name], pactl[:toggle]].join(' ')
      end

      def pactl_updown
        [pactl[:name], pactl[:updown]].join(' ')
      end

      # * AMIXER

      def amixer
        {
          name: 'amixer',
          toggle: '-q sset Master toggle',
          updown: "set Master #{STEP}%#{states[state]}"
        }
      end

      def amixer_toggle
        [amixer[:name], amixer[:toggle]].join(' ')
      end

      def amixer_updown
        [amixer[:name], amixer[:updown]].join(' ')
      end

      # * BSD MIXER

      def mixer
        {
          name: 'mixer',
          toggle: '',
          updown: "mixer vol #{states[state]}#{STEP}"
        }
      end

      def mixer_toggle
        [mixer[:name], mixer[:toggle]].join(' ')
      end

      def mixer_updown
        [mixer[:name], mixer[:updown]].join(' ')
      end

      # * MODES

      def toggle
        {
          pactl: pactl_toggle,
          amixer: amixer_toggle,
          mixer: mixer_toggle
        }
      end

      def updown
        {
          pactl: pactl_updown,
          amixer: amixer_updown,
          mixer: mixer_updown
        }
      end

      def mode
        {
          toggle: toggle[info.name],
          up: updown[info.name],
          down: updown[info.name]
        }
      end

      def final_command
        mode[state]
      end

      def run
        return unless %i[up down toggle].include?(state)

        system(final_command)
      end
    end
  end
end
