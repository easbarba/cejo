# frozen_string_literal: true

require_relative 'grabber'

require 'pathname'

module Cejo
  module Media
    # Get media pointed in url.
    class Get
      AUDIO_DIR = Pathname.new(Dir.home).join('Music')
      VIDEO_DIR = Pathname.new(Dir.home).join('Videos')
      AUDIO_FORMATS = %w[vorbis flac mp3].freeze
      VIDEO_FORMATS = %w[mkv mp4 ogg].freeze

      attr_reader :url, :codec, :grabber

      def initialize(url, codec = nil)
        @url = url if url
        @codec = codec if codec
        @grabber = Grabber.new(url, codec)
      end

      def current_dir
        AUDIO_FORMATS.include?(codec) ? AUDIO_DIR : VIDEO_DIR
      end

      def final_command
        AUDIO_FORMATS.include?(codec) ? grabber.audio_command : grabber.video_command
      end

      def show_info
        <<~INFO
          Title: #{grabber.title}
          Url: #{url} - Codec: #{codec} - Folder: #{current_dir}
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
