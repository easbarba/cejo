# frozen_string_literal: true

module Cejo
  # Process CLI arguments.
  module CLI
    # Provide arguments
    class Arguments
      attr_reader :arguments

      def initialize(arguments)
        @arguments = arguments
      end

      def show_help
        main = Help::Main.new(values[:command], values[:option])
        main.validate
      end

      def values
        result = {}
        names = [:command, :option, :rest]
        arguments.each_with_index do |arg, i|
          if i >= 2
            result.store(names[i], arguments.drop(2))
            break
          end
          arg = arg.to_sym
          result.store(names[i], arg)
        end
        result
      end
    end
  end
end
