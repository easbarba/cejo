# frozen_string_literal: true

module Cejo
  # Distro Front End
  module Distro
    # Base
    class Base
      attr_reader :folder, :utils
      attr_accessor :action, :arguments

      def initialize(folder, utils)
        @folder = folder
        @utils = utils
        @action = action
      end

      def commands
        parsed_commands = ParsedCommands.new(utils, folder).found
        commands = Commands.new parsed_commands

        exit unless commands.any?
        commands.all
      end

      def packager
        current_packager = CurrentPackager.new utils
        current_packager.packager commands.keys
      end

      def real_action
        result = TranslateAction.new
        result.real_action commands, packager, action
      end

      def need
        Need.new action
      end

      def final_command
        result = packager, real_action
        result.append arguments
        result.prepend 'sudo' if need.admin?
        result.join ' '
      end

      def run
        system final_command
      end
      public :run
    end
  end
end
