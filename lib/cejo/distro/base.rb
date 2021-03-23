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
        config_folder = ConfigFolder.new(folder).folder
        Commands.new(utils, config_folder).all
      end

      def packager
        current_packager = CurrentPackager.new(utils)
        current_packager.packager(commands.keys)
      end

      def translate_action
        result = TranslateAction.new
        result.real_action(commands, packager, action)
      end

      def need
        Need.new(action)
      end

      def final_command
        cmd = packager, translate_action
        cmd.append(arguments)
        cmd.prepend('sudo') if need.admin?
        cmd.join(' ')
      end

      def run
        puts(final_command)
        system(final_command)
      end
      public :run
    end
  end
end
