# frozen_string_literal: true

require 'pathname'

module Cejo
  module Media
    # Current grabber and media information
    class Grabber
      attr_reader :url, :name, :current, :parser
      attr_accessor :codec

      def initialize(url, codec, parser, current)
        @url = url
        @codec = codec
        @current = current
        @parser = parser
      end

      def video_command
        "#{current.video} #{codec} #{url}"
      end

      def audio_command
        "#{current.audio} #{codec} #{url}"
      end

      def title
        result = parser.info(current, :title, url)
        max_words = 6
        shorter_title = result.split[0...max_words].join(' ')

        result.split.size > max_words ? shorter_title : result
      end

      def extension
        parser.info(current, :ext, url)
      end

      def to_s
        "#{title}.#{extension}"
      end
    end
  end
end
