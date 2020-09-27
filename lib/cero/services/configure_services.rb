# frozen_string_literal: true

require_relative 'folders.rb'
require_relative 'git.rb'
require_relative 'os_utils.rb'

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
