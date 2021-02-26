# frozen_string_literal: true

module Cejo
  module Distro
    # Base
    class CurrentPackager
      attr_reader :utils, :all_commands

      def initialize(utils, all_commands)
        @utils = utils
        @all_commands = all_commands
      end

      def packager
        all_commands.find do
          |p| utils.has_program? p
        end
      end
    end
  end
end
