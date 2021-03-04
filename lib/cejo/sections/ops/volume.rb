# frozen_string_literal: true

module Cejo
  module Ops
    # Manage System Volume.
    class Volume
      STEP = 5
      attr_reader :state, :utils

      def initialize(utils, state)
        @utils = utils
        @state = state.to_sym
      end

      def managers
        %w[pactl amixer mixer]
      end

      def sound_manager
        managers.first { |manager| utils.which?(manager) }.to_sym
      end

      # * PACTL

      # Find the running Pactl sink
      def pactl_sink
        `pactl list sinks`.split("Sink #").each do |sink|
          sink_id = sink[0]
          return sink_id if sink.include? "State: RUNNING"
        end
      end

      def pactl_toggle
        [pactl[:name], pactl[:toggle]].join(" ")
      end

      def pactl_updown
        [pactl[:name], pactl[:updown]].join(" ")
      end

      def pactl
        {
          name: 'pactl',
          toggle: %W[set-sink-mute #{pactl_sink} toggle].join(" "),
          updown: %W[set-sink-volume #{pactl_sink} #{states[state]}#{STEP.to_s}%].join(" ")
        }
      end

      # * AMIXER

      def amixer_toggle
        [amixer[:name], amixer[:toggle]].join(" ")
      end

      def amixer_updown
        [amixer[:name], amixer[:updown]].join(" ")
      end

      def amixer
        {
          name: 'amixer',
          toggle: '-q sset Master toggle',
          updown: %W[set Master #{STEP}%#{states[state]}].join("")
        }
      end

      # * BSD MIXER

      def mixer_toggle
        [mixer[:name], mixer[:toggle]].join(" ")
      end

      def mixer_updown
        [mixer[:name], mixer[:updown]].join(" ")
      end

      def mixer
        {
          name: 'mixer',
          toggle: '',
          updown: %W[mixer vol #{states[state]}#{STEP}].join(" ")
        }
      end

      # * STATES

      def states
        {
          up: '+',
          down: '-',
          toggle: ''
        }
      end

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
          toggle: toggle[sound_manager],
          up: updown[sound_manager],
          down: updown[sound_manager]
        }
      end

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
