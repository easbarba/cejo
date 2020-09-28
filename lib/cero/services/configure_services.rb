# frozen_string_literal: true

require_relative 'folders'
require_relative 'git'
require_relative 'os_utils'

module Cero
  module Services
    # Provide Services
    class ConfigureServices
      attr_reader :git, :folders, :os_utils

      def initialize
        @git = Git.new
        @folders = Folders.new
        @os_utils = OsUtils.new
      end
    end
  end
end
