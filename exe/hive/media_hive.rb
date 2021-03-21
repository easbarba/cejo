# frozen_string_literal: true

module Cejo
  module Hive
    # Manage System media features
    class MediaHive
      attr_reader :services, :arguments

      def initialize(services, arguments)
        @services = services
        @arguments = arguments if arguments
      end

      public

      def features
        {
          play: Media::Play.new(arguments.first),
          get: Media::Get.new(arguments),
        }
      end
    end
  end
end
