# frozen_string_literal: true

require 'shellwords'

require 'clipboard'

module Cejo
  ## Provide system media interaction.
  module Media
    # Play file, random media in folder or with url provided by clipboard text.
    class Play
      attr_reader :file_path

      PLAYER = 'mpv'
      PLAYER_CONFIG = '--no-config --no-audio-display --ytdl-format="bestvideo[height<=?1080]+bestaudio/best"'

      private

      def initialize(file_path)
        @file_path = file_path
      end

      ## play random media in folder
      def pick_random_media_in_folder(media)
        media.join(Dir.entries(media).sample).to_s.shellescape
      end

      ## play media from clipboard url or file
      def choose_media_to_play
        return Clipboard.paste if file_path.nil?

        media = Pathname.new(file_path)

        return media.to_s if media.file?

        return pick_random_media_in_folder(media) if media.directory?
      end

      public

      def run_args
        "#{PLAYER} #{PLAYER_CONFIG} #{choose_media_to_play}"
      end

      def run
        Process.fork { system run_args }
      end
    end
  end
end
