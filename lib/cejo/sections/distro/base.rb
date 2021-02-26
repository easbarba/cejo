# frozen_string_literal: true

require_relative 'super_user'
require_relative 'current_packager'
require_relative 'parsed_action'

module Cejo
  # Distro Front End
  module Distro
    # Base
    class Base
      attr_reader :services, :arguments, :action

      private

      def initialize(services, arguments, action)
        @services = services
        @arguments = arguments
        @action = action.to_sym
      end

      def packager
        CurrentPackager.new.packager(services.utils)
      end

      def real_action
        parsed_action = ParsedAction.new(services, action)
        parsed_action.real_action(packager)
      end

      def super_needed?
        SuperUser.new.needed? real_action
      end

      def command
        cmd = [packager, real_action, arguments]
        cmd.prepend 'sudo' if super_needed?
        cmd.join(' ')
      end

      public

      def run
        system command
      end
    end
  end
end
