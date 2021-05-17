# frozen_string_literal: true

require 'pathname'

module Cejo
  module Media
    # Media information
    class Info
      attr_reader :url, :current
      attr_accessor :codec, :parser

      def initialize(url, codec, current)
        @url = url
        @codec = codec
        @current = current
        @parser = Cejo::Media::Parser.new(current, url)
      end

      def program
        current.name
      end

      def video_command
        "#{program} #{current.out} '#{current.title}.#{current.ext}' #{current.video} #{codec} #{url}"
      end

      def audio_command
        "#{program} #{current.out} '#{current.title}.#{current.ext}' #{current.audio} #{codec} #{url}"
      end

      def extension
        parser.fmt = :ext
        parser.result
      end

      def title
        parser.fmt = :title
        parser.result
      end

      def shorter_title(title)
        max_words = 6
        fixed = title.split[0...max_words].join(' ')

        title.split.size > max_words ? fixed : title
      end
      private :shorter_title

      def to_s
        "#{title}.#{extension}"
      end
    end
  end
end
