# frozen_string_literal: true

module Cejo
  module Hive
    # Media features
    class MediaHive
      attr_reader :services, :sub_option

      private

      def initialize(services, sub_option)
        @services = services
        @sub_option = sub_option
      end

      def play
        Media::Play.new(sub_option)
      end

      def get
        media = sub_option[0],
        codec = sub_option[1]
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
