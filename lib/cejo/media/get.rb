# frozen_string_literal: true

require 'pathname'

module Cejo
  module Media
    # Get media pointed in url.
    class Get
      GRABBER = 'youtube-dl'
      AUDIO_FORMATS = %w[vorbis flac mp3].freeze
      AUDIO_DIR = Pathname.new(Dir.home).join('Music')
      VIDEO_DIR = Pathname.new(Dir.home).join('Videos')

      attr_reader :media, :codec

      def initialize(media, codec = nil)
        @media = media if media
        @codec = codec if codec
      end

      def current_media
        "\'#{media}\'" unless media
      end

      def current_dir
        AUDIO_FORMATS.include?(codec) ? AUDIO_DIR : VIDEO_DIR
      end

      def audio_command
        "--extract-audio --audio-format #{codec} #{media}"
      end

      def video_command
        media
      end

      def final_command
        action = AUDIO_FORMATS.include?(codec) ? audio_command : video_command
        "#{GRABBER} #{action}"
      end

      def show_info
        <<~INFO
          "media: #{media}"
          "codec: #{codec}"
        INFO
      end

      def run
        show_info
        Dir.chdir(current_dir) { system final_command }
      end
    end
  end
end
