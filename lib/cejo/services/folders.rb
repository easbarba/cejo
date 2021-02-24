# frozen_string_literal: true

module Cejo::Services
  # System Folders
  class Folders
    attr_reader :xdg_config_home, :cejo_config, :downloads, :pictures

    def initialize
      home = Dir.home
      @xdg_config_home = Pathname.new(File.join(home, '.config'))
      @cejo_config = Pathname.new(File.join(xdg_config_home, 'cejo'))
      @downloads = Pathname.new(File.join(home, 'Downloads'))
      @pictures = Pathname.new(File.join(home, 'Pictures'))
    end
  end
end
