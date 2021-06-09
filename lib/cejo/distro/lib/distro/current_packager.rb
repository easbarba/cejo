# frozen_string_literal: true

module Cejo
  module Distro
    # Base
    class CurrentPackager
      attr_reader :utils

      def initialize(utils)
        @utils = utils
      end

      def packager(keys)
        keys.find { |exec| utils.which? exec }.to_sym
      end
    end
  end
end
