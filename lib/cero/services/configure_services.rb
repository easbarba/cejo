# frozen_string_literal: true

require_relative 'folders'
require_relative 'git'
require_relative 'utils'

module Cero
  # Utilities and System Software front-end.
  module Services
    # Provide Services
    class ConfigureServices
      attr_reader :git, :folders, :utils

      def initialize
        @git = Git.new
        @folders = Folders.new
        @utils = Utils.new
      end
    end
  end
end
