# frozen_string_literal: true

require_relative '../../sections/media/play'
require_relative '../../sections/media/getmedia'

module Cejo
  module Client
    # Media features
    class MediaClient
      attr_reader :services, :sub_option

      private

      def initialize(services, sub_option)
        @services = services
        @sub_option = sub_option
      end

      def play
        puts sub_option
        Cejo::Media::Play.new(sub_option).run
      end

      def getmedia
        Cejo::Media::Getmedia.new(sub_option).run
      end

      public

      def features
        {
          play: play,
          getmedia: getmedia
        }
      end
    end
  end
end
