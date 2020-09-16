# frozen_string_literal: true

module Cero
  module Services
    # System Folders
    class Folders
      attr_reader :xdg_config_home, :cero_config, :downloads, :pictures

      def initialize
        home = Dir.home
        @xdg_config_home = Pathname.new(File.join(home, '.config'))
        @cero_config = Pathname.new(File.join(xdg_config_home, 'cero'))
        @downloads = Pathname.new(File.join(home, 'Downloads'))
        @pictures = Pathname.new(File.join(home, 'Pictures'))
      end
    end
  end
end
