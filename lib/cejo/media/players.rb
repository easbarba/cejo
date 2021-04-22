# frozen_string_literal: true

module Cejo
  module Media
    # Availables media system players w/ settings
    class Players
      # player name, config and optimal media format
      Player_info = Struct.new :name, :config, :format do
        def to_s
          %(#{name} #{config} #{format})
        end
      end

      def mpv
        name = 'mpv'
        config = '--no-config --no-audio-display'
        format = '--ytdl-format="bestvideo[height<=?1080]+bestaudio/best"'

        Player_info.new(name, config, format)
      end

      def vlc
        name = 'vlc'

        Player_info.new(name, nil, nil)
      end
    end
  end
end
