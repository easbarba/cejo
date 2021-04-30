# frozen_string_literal: true

require 'pathname'

module Cejo
  module Media
    # Main caller
    class Main
      attr_reader :info

      def initialize(codec, url)
        current = Cejo::Media::Grabbers.new.youtube_dl
        @info = Cejo::Media::Info.new(url, codec, current)
      end

      def run
        Cejo::Media::Get.new(info).exec
      end
    end
  end
end
