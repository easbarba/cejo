# frozen_string_literal: true

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
        shotter.keys.first { |shotter| !services.os_utils.command?(shotter).nil? }
      end

      public

      def run_args
        shotter_avaiable
      end

      def run
        puts run_args
      end
    end
  end
end
