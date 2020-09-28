# frozen_string_literal: true

require_relative '../../sections/media/play'

module Cero
  module Client
    # Media features
    class MediaClient
      attr_reader :services, :action

      private

      def initialize(services, action)
        @services = services
        @action = action
      end

      def play
        Cero::Media::Play.new(action).run
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
