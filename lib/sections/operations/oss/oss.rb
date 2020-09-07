require 'pathname'
require 'json'
require 'uri'
# require 'git'

class Oss
  attr_reader :projects, :oss

  def initialize
    @projects = Pathname.new(File.join(Dir.home, 'Projects'))
    @oss = Pathname.new(File.join(Dir.home, '.config', 'cero', 'oss.json'))
  end

  def archive
  end

  def clone(project, language)
    url = URI(project)
    name = url.path.split('/').last
    folder = @projects.join(language, name)

    if folder.exist?
      puts "Cloning: #{name}"
    end
  end

  def start
    file = File.read(oss)
    parsed = JSON.parse(file)

    for language in parsed.keys
      puts "\n--> #{language}"
      parsed[language].each { |n| clone(n, language) }
    end
  end

end

x = Oss.new
x.start
