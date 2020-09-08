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

  def prepare(d, project, language)
    project_url = URI(project)
    project_name = project_url.path.split('/').last
    project_folder = @projects.join(language, project_name)

    puts "--> #{project_name}"
    d.call(project_url, project_folder)
  end

  def archive(project, language)
    archived_folder = Pathname.new(File.join(Dir.home, 'Downloads'))
    Dir.mkdir(archived_folder)

    archive_these = ['cero', 'lxbarbosa.github.io', 'documentos', 'ruby',
                     'rubygems', 'rubocop', 'rails', 'emacs-async', 'use-package',
                     'lsp-mode', 'emacs']

    format = 'zip'
    # repo_folder =
    to = archived_folder + project_name + zip
    # project_name =

    # archive thread

    puts to
  end

  def get(url, folder)
    puts "#{url} - #{folder}"
    # git.getter(url, folder)
  end

  def start
    @oss.keys.each do |language|
      puts "\n--> #{language}"
      @oss[language].each { |n| prepare(method(:get), n, language) }
    end
  end
end
