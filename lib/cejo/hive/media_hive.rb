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

      public

      def features
        {
          play: Media::Play.new(arguments[0]),
          get: Media::Get.new(arguments),
        }
      end
    end
  end
end
