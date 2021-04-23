# frozen_string_literal: true

require 'pathname'

module Cejo
  module Media
    # Get media pointed in url.
    class Get
      AUDIO_DIR = Pathname.new(Dir.home).join('Music')
      VIDEO_DIR = Pathname.new(Dir.home).join('Videos')
      AUDIO_FORMATS = %w[vorbis flac mp3].freeze
      VIDEO_FORMATS = %w[mkv mp4 ogg].freeze

      attr_reader :grabber

      def initialize(grabber)
        @grabber = grabber
      end

      def current_dir
        AUDIO_FORMATS.include?(grabber.codec) ? AUDIO_DIR : VIDEO_DIR
      end

      def final_command
        AUDIO_FORMATS.include?(grabber.codec) ? grabber.audio_command : grabber.video_command
      end

      def show_info
        <<~INFO
          Title: #{grabber.title}
          Url: #{grabber.url}
          Codec: #{grabber.codec}
          Folder: #{current_dir}
        INFO
      end

      def run
        puts show_info
        puts

        Dir.chdir(current_dir) { system "#{grabber.current.name} #{final_command}" }
      end
    end
  end
end
