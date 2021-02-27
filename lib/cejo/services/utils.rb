# frozen_string_literal: true

module Cejo::Services
  # General Utilities.
  class Utils
    def command?(name)
      [name, *ENV['PATH']
                .split(File::PATH_SEPARATOR)
                .map { |p| File.join(p, name) }]
        .find { |f| File.executable?(f) }
    end

    def info_and_exit(foo, *options)
      return unless foo.nil?

      puts ''
      puts 'Options:'

      options.each { |op| puts "  option: #{op}" }

      exit
    end

    def spin(msg)
      require 'tty-spinner'
      spinner = TTY::Spinner.new("status: #{msg.downcase} :spinner ", format: :dots_6)

      puts
      spinner.auto_spin

      yield

      spinner.success
      puts
    end

    # Load file with famous serialization formats
    def load_this(file, ext)
      case ext # TODO: load lazily per time. enumerator?
      when 'yaml'
        require 'yaml'
        YAML.load_file(file, symbolize_names: true)
      when 'json'
        require 'json'
        JSON.parse(file, symbolize_names: true)
      else
        return
      end
    end

    # Parse Folder with serialization files
    def parse_folder(folder, ext='yaml')
      projects = {}

      folder.each_child do |file|
        name = file.basename.sub_ext("").to_s.to_sym
        projects[name] = load_this(file, ext)
      end

      projects
    end

    # Program is available
    def has_program?(program)
      ENV['PATH'].split(File::PATH_SEPARATOR).any? do |directory|
        File.executable?(File.join(directory, program.to_s))
      end
    end
  end
end
