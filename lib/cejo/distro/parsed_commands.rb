# frozen_string_literal: true

module Cejo
  module Distro
    # Objectfy commands parsed
    class ParsedCommands
      attr_reader :utils, :folder

      def initialize(utils, folder)
        @utils = utils
        @folder = folder.join('distro')
      end

      def found
        utils.parse_folder(folder)
      end

      def any?
        packagers.any?
      end
    end
  end
end
