# frozen_string_literal: true

module Cero
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
        options.each { |op| puts "option: #{op}" }

        exit if foo.nil?
      end
    end
  end
end
