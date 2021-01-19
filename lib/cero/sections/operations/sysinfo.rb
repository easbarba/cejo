# frozen_string_literal: true

module Cero
  module Ops
    # Display System Hardware Information.
    class Sysinfo
      private

      attr_reader :services, :command

      DEPS = %w[pulseaudio amixer ping sensors ryzen vega].freeze

      def initialize(services, command)
        @services = services
        @command =  command
      end

      public

      def run_args
        DEPS
      end

      def run
        system(run_args)
      end
    end
  end
end
