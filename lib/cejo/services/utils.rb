# frozen_string_literal: true

require 'tty-spinner'

require 'yaml'

module Cejo
  module Services
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
        spinner = TTY::Spinner.new("status: #{msg.downcase} :spinner ", format: :dots_6)

        puts
        spinner.auto_spin

        yield

        spinner.success
        puts
      end

      # Parse Folder with serialization files
      def parse_folder(folder)
        projects = {}

        folder.each_child do |file|
          name = file.basename.sub_ext("").to_s.to_sym
          projects[name] = YAML.load_file file # instead load per time to avoid errors; enumerator?
        end

        projects
      end
    end
  end
end
