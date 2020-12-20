# frozen_string_literal: true

module Cero
  module Services
    # Operation System Utilities.
    class OsUtils
      def command?(name)
        [name, *ENV['PATH'].split(File::PATH_SEPARATOR).map { |p| File.join(p, name) }].find { |f| File.executable?(f) }
      end
    end
  end
end
