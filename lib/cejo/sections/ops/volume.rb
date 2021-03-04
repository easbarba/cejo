# frozen_string_literal: true

module Cejo
  module Ops
    # Manage System Volume.
    class Volume
      attr_reader :state, :utils

      STEP = 5

      def initialize(utils, state)
        @utils = utils
        @state = state.to_sym
      end

      def sound_manager
        manager = %w[pactl amixer mixer].first { |manager| utils.which?(manager) }
        manager.to_sym
      end

      def states
        {
          up: '+',
          down: '-',
          toggle: ''
        }
      end

      # Find the running Pactl sink
      def pactl_sink
        `pactl list sinks`.split("Sink #").each do |sink|
          sink_id = sink[0]
          return sink_id if sink.include? "State: RUNNING"
        end
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
          toggle: "set-sink-mute #{pactl_sink} toggle",
          updown: "set-sink-volume #{pactl_sink} #{states[state]}#{STEP}%"
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

      def final_command
        mode[state]
      end

      def run
        unless [:up, :down, :toggle].include?(state)
          utils.info_and_exit(state, 'up', 'down', 'toggle')
          return
        end

        system(final_command)
      end
    end
  end
end
