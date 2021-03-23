# frozen_string_literal: true

module Cejo
  module Distro
    # Base
    class Commands
      attr_reader :utils, :folder

      def initialize(utils, folder)
        @utils = utils
        @folder = folder
      end

      def all
        utils.parse_folder(folder)
      end

      def actions
        puts
      end

      def packagers
        all.keys
      end
    end
  end
end
