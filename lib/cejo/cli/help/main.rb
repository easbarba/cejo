# frozen_string_literal: true

module Cejo
  # Process CLI arguments.
  module CLI
    # Inform user about sections and commands available
    module Help
      class Main
        attr_reader :section, :feature, :arguments

        def initialize(section, feature, arguments)
        end

        def validate
          ''
        end

        def run
          ''
        end
      end
    end
  end
end
