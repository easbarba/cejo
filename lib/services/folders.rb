# frozen_string_literal: true

# System Folders
class Folders
  attr_reader :xdg_config_home, :cero_config, :downloads, :pictures

  def initialize
    home = Dir.home
    xdg_config_home = Pathname.new(File.join(home, '.config', 'cero'))
    cero_config = File.join(xdg_config_home, 'cero')
    downloads = (File.join(home, 'Downloads'))
  end
end
