# frozen_string_literal: true

module Cejo
  # Provide system media interaction.
  module Media
    # Play file, random media in folder or with url.
    class Play
      PLAYER = 'mpv'
      PLAYER_CONFIG = '--no-config --no-audio-display'
      PLAYER_FORMAT = '--ytdl-format="bestvideo[height<=?1080]+bestaudio/best"'

      attr_reader :media

      def initialize(media)
        @media = media
      end

      def pick_random_media_in_folder(folder)
        file = folder.children.sample
        folder.join(file).to_path
      end

      def pick_media
        filepath = Pathname.new(media)
        return filepath.to_path if filepath.file?

        return pick_random_media_in_folder(filepath) if filepath.directory?

        media
      end

      def player_settings
        "#{PLAYER} #{PLAYER_CONFIG} #{PLAYER_FORMAT}"
      end

      def final_command
        "#{player_settings} #{pick_media}"
      end

      def run
        system final_command
      end
    end
  end
end
