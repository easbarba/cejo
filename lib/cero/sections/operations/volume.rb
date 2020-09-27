# frozen_string_literal: true

module Cero
  module Ops
    # Manage System Volume.
    class Volume
      attr_reader :step, :sound_manager, :state

      private

      def initialize(services, state)
        @services = services
        @state = state.to_sym
        @step = 5

        sound_managers = %w[pactl amixer mixer]
        @sound_manager = sound_managers.first { |m| !services.os_utils.command?(m).nil? }
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
          updown: "set Master #{step}%#{states[state]}"
        }
      end

      def pactl
        {
          name: 'pactl',
          toggle: 'set-sink-mute 0 toggle',
          updown: "set-sink-volume 0 #{states[state]}#{step}%"
        }
      end

      def mixer
        {
          name: 'mixer',
          toggle: '',
          updown: "mixer vol #{states[state]} #{step}"
        }
      end

      def toggle
        {
          pactl: pactl[:name] + ' ' + pactl[:toggle],
          amixer: amixer[:name] + ' ' + amixer[:toggle],
          mixer: mixer[:name] + ' ' + mixer[:toggle]
        }
      end

      def updown
        {
          pactl: pactl[:name] + ' ' + pactl[:updown],
          amixer: amixer[:name] + ' ' + amixer[:updown],
          mixer: mixer[:name] + ' ' + mixer[:updown]
        }
      end

      def mode
        {
          toggle: toggle[sound_manager.to_sym],
          up: updown[sound_manager.to_sym],
          down: updown[sound_manager.to_sym]
        }
      end

      public

      def run_args
        mode[state]
      end

      def run
        system(run_args)
      end
    end
  end
end
