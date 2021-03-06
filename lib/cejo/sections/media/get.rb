# frozen_string_literal: true

require 'clipboard'
require 'colorize'

require 'pathname'

module Cejo::Media
  # Get media provided in clipboard or arguments.
  class Get
    GRABBER = 'youtube-dl'.freeze
    AUDIO_FORMATS = %w[vorbis flac mp3].freeze
    AUDIO_DIR = Pathname.new(Dir.home).join('Music')
    VIDEO_DIR = Pathname.new(Dir.home).join('Videos')

    attr_reader :media, :codec

    def initialize(media, codec)
      @media = "\'#{media}\'"
      @codec = codec
    end

    def cur_media
      media.nil? ? system_text : media
    end

    def cur_dir
      AUDIO_FORMATS.include?(codec) ? AUDIO_DIR : VIDEO_DIR
    end

    def audio_command
      "--extract-audio --audio-format #{codec} #{media}"
    end

    def video_command
      media
    end

    def system_text
      Clipboard.paste
    end

    def final_command
      action = AUDIO_FORMATS.include?(codec) ? audio_command : video_command
      "#{GRABBER} #{action}"
    end

    def show_info
      print "media:".red, " #{media}"
      puts
      print "codec:".red, " #{codec}"
    end

    def run
      show_info

      Dir.chdir(cur_dir) do
        Process.fork { system final_command }
      end
    end
  end
end
