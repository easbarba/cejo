# frozen_string_literal: true

require 'shellwords'

require 'clipboard'

module Cero
  ## Provide system media interaction.
  module Media
    # Play file, random media in folder or with url provided by clipboard text.
    class Play
      attr_reader :projects, :git, :file_path, :player

      private

      def initialize(file_path)
        @file_path = Pathname(file_path)

        @player = 'mpv'
      end

      def player_config
        player_video_quality = %s(--ytdl-format="bestvideo[height<=?1080]+bestaudio/best")
        "--no-config --no-audio-display #{player_video_quality}"
      end

      ## play random media in folder
      def pick_folder_random_media
        file_path.join(Dir.entries(file_path).sample).to_s.shellescape
      end

      ## play media from clipboard url or file
      def choose_media_to_play
        return file_path.to_s if file_path.file?

        return pick_folder_random_media if file_path.directory?

        Clipboard.paste
      end

      public

      def run_args
        "#{player} #{player_config} #{choose_media_to_play}"
      end

      def run
        Process.fork { system run_args }
      end
    end
  end
end
