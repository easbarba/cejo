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

      attr_reader :info

      def initialize(info)
        @info = info
      end

      def current_dir
        AUDIO_FORMATS.include?(info.codec) ? AUDIO_DIR : VIDEO_DIR
      end

      def final_command
        AUDIO_FORMATS.include?(info.codec) ? info.audio_command : info.video_command
      end

      def show_info
        puts <<~INFO
          Title: #{info.title}
          Url: #{info.url}
          Codec: #{info.codec}
          Folder: #{current_dir}
        INFO

        puts
      end

      def exec
        show_info

        Dir.chdir(current_dir) { system final_command }
      end
    end
  end
end
