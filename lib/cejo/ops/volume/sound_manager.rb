# frozen_string_literal: true

module Cejo
  module Ops
    # Sound manager information
    class SoundManager
      attr_reader :utils

      def initialize(utils)
        @utils = utils
      end

      # Find the running Pactl sink
      def pactl_sink
        `pactl list sinks`.split('Sink #').each do |sink|
          sink_id = sink[0]
          return sink_id if sink.include? 'State: RUNNING'
        end
      end

      def sink
        {
          pactl: pactl_sink
        }
      end

      def sound_managers
        %w[pactl amixer mixer]
      end

      def sound_manager
        sound_managers.first { |manager| utils.which?(manager) }.to_sym
      end

      ALL = Struct.new(:name, :sink)
      def info
        ALL.new(sound_manager, sink[sound_manager])
      end

      def to_s
        "#{sound_manager} #{sink}"
      end
    end
  end
end
