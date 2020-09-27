# frozen_string_literal: true

require_relative '../../sections/media/play.rb'

module Cero
  module Client
    # Media features
    class MediaClient
      attr_reader :services, :action

      def initialize(action)
        @action = action.size.zero? ? nil : action.deq
      end

      def play
        Cero::Media::Play.new(action).run
      end

      def features
        {
          play: play
        }
      end
    end
  end
end
