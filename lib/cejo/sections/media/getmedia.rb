# frozen_string_literal: true

require 'clipboard'

require 'pathname'

module Cejo::Media
  # Get media provided in clipboard or arguments.
  class Getmedia
    private

    attr_reader :media, :codec

    GRABBER = 'youtube-dl'
    SUPPORTED_FORMATS = %w[vorbis flac mp3].freeze

    def initialize(codec, media)
      @media = media
      @codec = codec
      @media = media.nil? ? Clipboard.paste : media
    end

    def grab_audio
      dir = Pathname.new(Dir.home).join('Music')
      "--extract-audio --audio-format #{codec} #{media} #{dir}"
    end

    def grab_video
      dir = Pathname.new(Dir.home).join('Videos')
      "#{media} #{dir}"
    end

    def run_args
      media = SUPPORTED_FORMATS.include?(@codec) ? grab_audio : grab_video
      "#{GRABBER} #{media}"
    end

    public

    def run
      puts run_args
      # Process.fork { system run_args }
    end
  end
end
