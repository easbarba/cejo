# frozen_string_literal: true

require 'pathname'

module Cejo
  module Media
    # Avaialable grabbers
    class Grabbers
      INFO = Struct.new(:name, :parser, :out, :ext, :title, :audio, :video) do
        def to_s
          %(#{name} #{audio} #{video})
        end
      end

      # youtube-dl formats
      def youtube_dl
        INFO.new('youtube-dl', '--get-filename -o', '--output', '%(ext)s',
                 '%(title)s', '--extract-audio --audio-format', '--recode-video')
      end
    end
  end
end
