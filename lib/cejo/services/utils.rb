# frozen_string_literal: true

require 'tty-spinner'

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
        spinner = TTY::Spinner.new(":spinner #{msg}", format: :dots_6)

        puts
        spinner.auto_spin

        yield

        spinner.stop('Done!')
        puts
      end

    end
  end
end
