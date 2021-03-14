# frozen_string_literal: true

module Cejo
  # Distro Front End
  module Distro
    # Base
    class Base
      attr_reader :folder, :utils, :arguments, :action, :cfg_folder

      def initialize(folders, utils, arguments, action)
        @folder = folders.cejo_config
        @utils = utils
        @arguments = arguments
        @action = action.to_sym
      end

      def commands
        cfg_folder = ConfigFolder.new(folder).folder
        cmds = utils.parse_folder cfg_folder
        Commands.new(cmds).all
      end

      def packager
        cur_pack = CurrentPackager.new(utils)
        cur_pack.packager(commands.keys)
      end

      def trans_action
        result = TranslateAction.new
        result.real_action(commands, packager, action)
      end

      def need
        Need.new(action)
      end

      def final_command
        cmd = packager, trans_action
        cmd.append arguments unless arguments.nil?
        cmd.prepend 'sudo' if need.admin?
        cmd.join(' ')
      end

      def run
        system final_command
      end

      public :run
    end
  end
end
