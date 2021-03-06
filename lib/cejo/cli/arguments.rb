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

      def get_args
        args = parse_args[:arguments]
        size = parse_args[:size]

        result = {}
        result.store(:command, args[0].to_sym) if size >= 1
        result.store(:option, args[1].to_sym) if size >= 2
        result.store(:arguments, args.drop(2)) if size >= 3

        result
      end

      def parse_args
        {
          arguments: arguments,
          size: arguments.size
        }
      end
    end
  end
end
