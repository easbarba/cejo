# frozen_string_literal: true

require 'clipboard'
require 'shellwords'

module Cero
  ## Provide system media interaction.
  module Media
    # Play file, random media in folder or with url provided by clipboard text.
    class Play
      attr_reader :projects, :git, :file_path, :player, :player_config

      private

      def initialize(file_path)
        @file_path = Pathname(file_path) unless file_path.nil?

        @player = 'mpv'
        player_video_quality = %s(--ytdl-format="bestvideo[height<=?1080]+bestaudio/best")
        @player_config = "--no-config --no-audio-display #{player_video_quality}"
      end

      ## play random media in folder
      def pick_folder_random_media
        file_path.join(Dir.entries(file_path).sample).to_s.shellescape
      end

      ## play media from clipboard url or file
      def choose_media_to_play
        return Clipboard.paste if file_path.nil?

        return pick_folder_random_media if file_path.directory?

        return file_path if file_path.file?
      end

      public

      def run_args
        "#{player} #{player_config} #{choose_media_to_play}"
      end

      def run
        system(run_args)
      end
    end
  end
end
