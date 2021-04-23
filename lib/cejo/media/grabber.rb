# frozen_string_literal: true

require 'pathname'

module Cejo
  module Media
    # Current grabber and media information
    class Grabber
      attr_reader :url, :codec, :name, :title, :extension, :current

      def initialize(url, codec)
        @url = url if url
        @codec = codec if codec

        @current = Grabbers.new.youtube_dl
        @title = parse_title
        @extension = parse_extension
      end

      def parse_filename(info)
        result = "#{current.name} #{current.parser} '#{info}' #{url}"

        `#{result}`.strip
      end

      def video_command
        "#{current.video_config} #{codec || 'mkv'} #{url}"
      end

      def audio_command
        "#{current.audio_config} #{codec} #{url}"
      end

      def parse_title
        result = parse_filename current.title_fmt

        max_words = 6
        shorter_title = result.split[0...max_words].join(' ')
        result.split.size > max_words ? shorter_title : result
      end

      def parse_extension
        parse_filename current.extension_fmt
      end

      def to_s
        "#{title}.#{extension}"
      end
    end
  end
end
