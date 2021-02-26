# frozen_string_literal: true

require_relative 'super_user'
require_relative 'current_packager'
require_relative 'parsed_action'

module Cejo
  # Distro Front End
  module Distro
    # Base
    class Base
      attr_reader :services, :action, :arguments

      private

      def initialize(services, action, arguments)
        @services = services
        @arguments = arguments
        @action = action
      end

      def final_command
        packer = CurrentPackager.new.packager(services.utils)
        real_action = ParsedAction.new(services, action).real_action(packer)

        cmd = [packer, real_action, arguments]
        cmd.prepend 'sudo' if SuperUser.new.needed?(action)
        cmd.join(' ')
      end

      public

      def run
        system(final_command)
      end
    end
  end
end
