# frozen_string_literal: true

module Cejo
  module Client
    # Distro features
    class DistroClient
      attr_reader :services, :command

      private

      def initialize(services, command)
        @services = services
        @command = command
      end

      public

      def features
        {}
      end
    end
  end
end
