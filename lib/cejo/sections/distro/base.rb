# frozen_string_literal: true

require_relative 'action'
require_relative 'config_folder'
require_relative 'commands'
require_relative 'current_packager'
require_relative 'need'

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
        @action = action
      end

      def commands
        raw_cmds = ConfigFolder.new(services).raw_commands
        Commands.new(raw_cmds).all
      end

      def packer
        pack = CurrentPackager.new(services.utils, commands.all)
        pack.packager
      end

      def real_action
        Action.new(services, action).real_action(packer)
      end

      def need
        Need.new
      end

      def final_command
        cmd = [packer, real_action, arguments]
        cmd.prepend 'sudo' if need.admin?(real_action)
        cmd.join(' ')
      end

      public

      def run
        puts final_command
      end
    end
  end
end
