# frozen_string_literal: true

module Cejo
  module Ops
    # Manage System Volume.
    class Volume
      attr_reader :state

      STEP = 5

      def initialize(services, state)
        @services = services
        @state = state
      end

      private

      def sound_manager
        manager = %w[pactl amixer mixer].first { |m| services.os_utils.which?(m) }
        manager.to_sym
      end

      def states
        {
          up: '+',
          down: '-',
          toggle: ''
        }
      end

      def amixer
        {
          name: 'amixer',
          toggle: '-q sset Master toggle',
          updown: "set Master #{STEP}%#{states[state]}"
        }
      end

      def pactl
        {
          name: 'pactl',
          toggle: 'set-sink-mute 0 toggle',
          updown: "set-sink-volume 0 #{states[state]}#{STEP}%"
        }
      end

      def mixer
        {
          name: 'mixer',
          toggle: '',
          updown: "mixer vol #{states[state]} #{STEP}"
        }
      end

      def pactl_toggle
        "#{pactl[:name]} #{pactl[:toggle]}"
      end

      def amixer_toggle
        "#{amixer[:name]} #{amixer[:toggle]}"
      end

      def mixer_toggle
        "#{mixer[:name]} #{mixer[:toggle]}"
      end

      def toggle
        {
          pactl: pactl_toggle,
          amixer: amixer_toggle,
          mixer: mixer_toggle
        }
      end

      def pactl_updown
        "#{pactl[:name]} #{pactl[:updown]}"
      end

      def amixer_updown
        "#{amixer[:name]} #{amixer[:updown]}"
      end

      def mixer_updown
        "#{mixer[:name]} #{mixer[:updown]}"
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
          toggle: toggle[sound_manager],
          up: updown[sound_manager],
          down: updown[sound_manager]
        }
      end

      public

      def run_args
        mode[state]
      end

      def run
        @services.utils.info_and_exit(state, '+', '-', 'toggle')
        @state = state.to_sym if %w[up down toggle].include? state

        system(run_args)
      end
    end
  end
end
