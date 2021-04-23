# frozen_string_literal: true

require 'pathname'

module Cejo
  module Media
    # Avaialable grabbers
    class Grabbers
      GRABBER_INFO = Struct.new :name, :parser, :extension_fmt, :title_fmt, :audio_config, :video_config do
        def to_s
          %(#{name} #{audio_config} #{video_config})
        end
      end

      def youtube_dl
        GRABBER_INFO.new('youtube-dl', '--get-filename -o', '%(ext)s', '%(title)s', '--extract-audio --audio-format', '--recode-video')
      end
    end
  end
end
