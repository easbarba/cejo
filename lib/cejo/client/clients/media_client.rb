# frozen_string_literal: true

require_relative '../../sections/media/play'
require_relative '../../sections/media/getmedia'

module Cejo
  module Client
    # Media features
    class MediaClient
      attr_reader :services, :command, :subcommand

      private

      def initialize(services, command, subcommand)
        @services = services
        @command = command
        @subcommand = subcommand
      end

      def play
        Cejo::Media::Play.new(command).run
      end

      def getmedia
        Cejo::Media::Getmedia.new(command, subcommand).run
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
