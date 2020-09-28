# frozen_string_literal: true

require 'date'

module Cero
  module Ops
    # Symlink Dotfiles to $HOME
    class Screenshot
      attr_reader :services, :shotters

      private

      def initialize(services)
        @services = services
        @shotters = { scrot: '', maim: '' }
      end

      def shotter_avaiable
        shotters.keys.first { |shotter| services.os_utils.which?(shotter) }
      end

      def current_time
        Time.new.strftime('%d-%m-%Y-%k:%M')
      end

      def screen_folder
        Pathname.new(Dir.home)
                .join('Pictures')
                .join("screenshot-#{current_time}.png")
      end

      public

      def run_args
        "#{shotter_avaiable} #{screen_folder}"
      end

      def run
        system(run_args)
      end
    end
  end
end
