# frozen_string_literal: true

module Cejo
  module Ops
    # Take a shot of the marvelous screen
    class Screenshot
      attr_reader :utils, :mode

      def initialize(utils, mode)
        @utils = utils
        @mode = mode.to_sym
      end

      def folder
        Pathname.new(Dir.home).join('Pictures') # TODO: Check if folder exist
      end

      def shotters
        [flameshot, scrot, maim]
      end

      def shotters_available
        shotters.select { |shotter| utils.which?(shotter[:exec]) }
      end

      def shotter
        shotters_available.first
      end

      def scrot
        {
          exec: 'scrot',
          full: '--focused --silent',
          partial: '--select --silent',
          folder: folder.join(screenshot_name)
        }
      end

      def flameshot
        {
          exec: 'flameshot',
          full: 'full -p',
          partial: 'gui -p',
          folder: folder.to_path
        }
      end

      def maim
        {
          exec: 'maim',
          full: '',
          partial: '--select',
          folder: folder.join(screenshot_name)
        }
      end

      def current_time
        Time.new.strftime('%d-%m-%y-%k-%M')
      end

      def screenshot_format
        'png'
      end

      def screenshot_name
        "screenshot-#{current_time}.#{screenshot_format}"
      end

      def final_command
        "#{shotter[:exec]} #{shotter[mode]} #{shotter[:folder]}"
      end

      def run
        system(final_command)
      end
    end
  end
end
