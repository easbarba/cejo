# frozen_string_literal: true

require_relative 'folders.rb'
require_relative 'git.rb'

module Cero
  module Services
    # Provide Services
    class ConfigureServices
      attr_reader :git, :folders

      def initialize
        @git = Git.new
        @folders = Folders.new
      end
    end
  end
end
