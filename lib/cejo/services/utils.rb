# frozen_string_literal: true

require 'tty-spinner'

require 'yaml'

module Cejo
  module Services
    # General Utilities.
    class Utils
      def info_and_exit(foo, *options)
        return unless foo.nil?

        puts ''
        puts 'Options:'

        options.each { |op| puts "  option: #{op}" }

        exit
      end

      def spin(msg)
        require 'colorize'
        warning = 'status:'.yellow.bold

        require 'tty-spinner'
        spinner = TTY::Spinner.new("#{warning} #{msg.downcase} :spinner ", format: :dots_6)
        spinner.auto_spin

        yield
        spinner.success
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
      def parse_folder(folder, ext = 'yaml')
        projects = {}

        folder.each_child do |file|
          name = file.basename.sub_ext('').to_s.to_sym
          projects[name] = load_this(file, ext)
        end

        projects
      end

      # Is the executable available?
      def which?(executable)
        ENV['PATH'].split(File::PATH_SEPARATOR).any? do |directory|
          File.executable?(File.join(directory, executable.to_s))
        end
      end
    end
  end
end
