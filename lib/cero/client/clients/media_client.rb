# frozen_string_literal: true

require 'sections/media/play'
require 'sections/media/getmedia'

module Cero
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
        Cero::Media::Play.new(command).run
      end

      def getmedia
        Cero::Media::Getmedia.new(command, subcommand).run
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
