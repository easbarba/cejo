# frozen_string_literal: true

require_relative '../../sections/media/play.rb'

module Cero
  module Client
    # Return Media Modules
    class MediaClient
      attr_reader :services, :action

      def initialize(action)
        @action = action.size.zero? ? nil : action.deq
      end

      def play
        Cero::Media::Play.new(action)
      end

      def modules
        {
          play: play.run
        }
      end
    end
  end
end
