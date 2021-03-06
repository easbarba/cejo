# frozen_string_literal: true

module Cejo
  module Hive
    # Manage System media features
    class MediaHive
      attr_reader :services, :arguments

      private

      def initialize(services, arguments)
        @services = services
        @arguments = arguments
      end

      def play
        Media::Play.new(arguments)
      end

      def get
        media = arguments[0],
        codec = arguments[1]
        Media::Get.new(media[0], codec)
      end

      public

      def features
        {
          play: play,
          get: get
        }
      end
    end
  end
end
