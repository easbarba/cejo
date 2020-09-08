require 'pathname'
require 'json'
require 'uri'
# require 'git'

class Oss
  attr_reader :projects, :oss

  def initialize
    # TODO: Use folders module
    @projects = Pathname.new(File.join(Dir.home, 'Projects'))
    xdg_config_home = Pathname.new(File.join(Dir.home, '.config'))
    cero_config = xdg_config_home.join('cero')

    file_path = cero_config + 'oss.json'
    @oss = JSON.parse(File.read(file_path))
  end

  def prepare(callback, project, language)
    project_url = URI(project)
    project_name = project_url.path.split('/').last
    project_folder = @projects.join(language, project_name)

    callback.call(project_url, project_folder, project_name)
  end

  def archive(x, folder, name)
    archives_folder = Pathname.new(File.join(Dir.home, 'Downloads', 'projects'))
    Dir.mkdir(archives_folder) unless archives_folder.exist?

    archive_these = ['cero', 'lxbarbosa.github.io', 'documentos', 'ruby',
                     'rubygems', 'rubocop', 'rails', 'emacs-async', 'use-package',
                     'lsp-mode', 'emacs']

    to = archives_folder + name

    if archive_these.include?(name) # archive thread
      puts "Archiving: #{name}"
      # git.archive(to, folder)
    end
  end

  def get(url, folder, name)
    puts "Getting: #{name}"
    puts "#{url} - #{folder}"
    # git.getter(url, folder)
  end

  def start(action)
    @oss.keys.each do |language|
      puts "\n--> #{language}"

      if action == "get"
        @oss[language].each { |n| prepare(method(:get), n, language) }
      elsif action == "archive"
        @oss[language].each { |n| prepare(method(:archive), n, language) }
      end
    end
  end
end
