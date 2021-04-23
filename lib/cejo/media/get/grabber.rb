# frozen_string_literal: true

require 'pathname'

module Cejo
  module Media
    # Current grabber and media information
    class Grabber
      attr_reader :url, :codec, :name, :current
      attr_accessor :parser

      def initialize(url, codec)
        @url = url
        @codec = codec

        @current = Grabbers.new.youtube_dl
        @parser = GrabberParser.new
      end

      def video_command
        "#{current.video_config} #{codec} #{url}"
      end

      def audio_command
        "#{current.audio_config} #{codec} #{url}"
      end

      def title
        result = parser.info(current, current.title_fmt, url)
        max_words = 6
        shorter_title = result.split[0...max_words].join(' ')

        result.split.size > max_words ? shorter_title : result
      end

      def extension
        parser.info(current, current.extension_fmt, url)
      end

      def to_s
        "#{title}.#{extension}"
      end
    end
  end
end
