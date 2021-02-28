# frozen_string_literal: true

require 'pathname'

module Cejo
  module Services
    # System Folders
    class Folders
      attr_reader :cejo_config, :downloads, :pictures, :local

      def initialize
        home = Dir.home
        xdg_config_home = Pathname.new(File.join(home, '.config'))
        @cejo_config = Pathname.new(File.join(xdg_config_home, 'cejo'))
        @downloads = Pathname.new(File.join(home, 'Downloads'))
        @pictures = Pathname.new(File.join(home, 'Pictures'))
        @local = Pathname.new(File.join(home, '.local'))
      end
    end
  end
end
