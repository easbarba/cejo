# frozen_string_literal: true

module Cejo
  module Hive
    # Manage System media features
    class MediaHive
      attr_reader :services, :arguments

      private

      def initialize(services, arguments)
        @services = services
        @arguments = arguments unless arguments.nil?
      end

      def play
        Media::Play.new(arguments[0])
      end

      def get
        Media::Get.new(arguments)
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
