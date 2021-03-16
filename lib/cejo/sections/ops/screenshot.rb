# frozen_string_literal: true

require 'date'

module Cejo
  module Ops
    # Take a shot of the marvelous screen
    class Screenshot
      attr_reader :utils

      def initialize(utils)
        @utils = utils
      end

      def shotters
        { scrot: 'scrot', maim: 'maim' }
      end

      def shotter_avaiable
        shotters.keys.first { |shotter| return shotter if utils.which?(shotter) }.to_sym
      end

      def current_time
        Time.new.strftime('%d-%m-%Y-%k:%M')
      end

      def pictures_folder
        Pathname.new(Dir.home).join('Pictures')
      end

      def screenshot_name
        "screenshot-#{current_time}.png"
      end

      def final_command
        "#{shotters[shotter_avaiable]} #{screenshot_name}"
      end

      public

      def run
        Dir.chdir(pictures_folder) {
          system(final_command)
        }
      end
    end
  end
end
