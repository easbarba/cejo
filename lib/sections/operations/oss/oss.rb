require 'pathname'
require 'json'
require 'uri'
# require 'git'

class Oss
  attr_reader :projects, :oss

  def initialize
    @projects = Pathname.new(File.join(Dir.home, 'Projects'))

    file_path = Pathname.new(File.join(Dir.home, '.config', 'cero', 'oss.json'))
    @oss = JSON.parse(File.read(file_path))
  end

  def archive; end

  def clone(project, language)
    project_url = URI(project)
    project_name = project_url.path.split('/').last
    project_folder = @projects.join(language, project_name)

    puts "Cloning: #{project_name}" if project_folder.exist?
  end

  def start
    @oss.keys.each do |language|
      puts "\n--> #{language}"
      @oss[language].each { |n| clone(n, language) }
    end
  end
end

x = Oss.new
x.start
