# frozen_string_literal: true

module Cejo
  module Media
    # Availables media system players w/ settings
    class Players
      # player name, config and optimal media format
      PLAYER_INFO = Struct.new :name, :config, :format do
        def to_s
          %(#{name} #{config} #{format})
        end
      end

      def mpv
        name = 'mpv'
        config = '--no-config --no-audio-display'
        format = '--ytdl-format="bestvideo[height<=?1080]+bestaudio/best"'

        PLAYER_INFO.new(name, config, format)
      end

      def vlc
        name = 'vlc'

        PLAYER_INFO.new(name, nil, nil)
      end
    end
  end
end
