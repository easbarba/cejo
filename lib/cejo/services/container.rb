# frozen_string_literal: true

module Cejo
  # Utilities and System Software front-end.
  module Services
    # Provide Services
    class Container  # TODO: Build a minimal IoC
      attr_reader :folders, :utils

      def initialize
        @folders = Folders.new
        @utils = Utils.new
      end
    end
  end
end
