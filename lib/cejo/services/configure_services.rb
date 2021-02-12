# frozen_string_literal: true

require_relative 'folders'
require_relative 'utils'

module Cejo
  # Utilities and System Software front-end.
  module Services
    # Provide Services
    class ConfigureServices
      attr_reader :folders, :utils

      def initialize
        @folders = Folders.new
        @utils = Utils.new
      end
    end
  end
end
