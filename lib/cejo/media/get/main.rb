# frozen_string_literal: true

require 'pathname'

module Cejo
  module Media
    # Main caller
    class Main
      attr_reader :grabber

      def initialize(url, codec = nil)
        @grabber = Grabber.new(url, codec, GrabberParser.new, Grabbers.new.youtube_dl)
      end

      def run
        Cejo::Media::Get.new(grabber).run
      end
    end
  end
end
