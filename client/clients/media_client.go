# frozen_string_literal: true

require_relative '../../sections/media/play'

module Cero
  module Client
    # Media features
    class MediaClient
      attr_reader :services, :command

      private

      def initialize(services, command)
        @services = services
        @command = command
      end

      def play
        Cero::Media::Play.new(command).run
      end

      public

      def features
        {
          play: play
        }
      end
    end
  end
end
