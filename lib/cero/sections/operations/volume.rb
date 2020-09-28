# frozen_string_literal: true

module Cero
  module Ops
    # Manage System Volume.
    class Volume
      attr_reader :step, :sound_manager, :state

      private

      def initialize(services, state)
        @services = services
        @state = state.to_sym if %w[up down toggle].include? state
        @step = 5

        @sound_manager = %w[pactl amixer mixer].first { |m| !services.os_utils.command?(m).nil? }
        @sound_manager = sound_manager.to_sym
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
          pactl: "#{pactl[:name]} #{pactl[:toggle]}",
          amixer: "#{amixer[:name]} #{amixer[:toggle]}",
          mixer: "#{mixer[:name]} #{mixer[:toggle]}"
        }
      end

      def updown
        {
          pactl: "#{pactl[:name]} #{pactl[:updown]}",
          amixer: "#{amixer[:name]} #{amixer[:updown]}",
          mixer: "#{mixer[:name]} #{mixer[:updown]}"
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
        system(run_args)
      end
    end
  end
end
