module Folders
  attr_reader :xdg_config_home, :cero_config, :downloads, :pictures

  def initialize
    xdg_config_home = Pathname.new(File.join(Dir.home, '.config', 'cero'))
    cero_config = xdg_config_home.join('cero')
    downloads = Dir.home.join('Downloads')
  end
end
