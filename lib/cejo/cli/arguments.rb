# frozen_string_literal: true

module Cejo
  # Process CLI arguments.
  module CLI
    # Provide arguments
    class Arguments
      attr_reader :arguments

      # Structure cli arguments
      ARGS_DATA = Struct.new(:command, :option, :sub_option)

      def initialize(arguments)
        @arguments = arguments
      end

      def get_args
        args = parse_args

        command = args.deq.to_sym
        option = args.deq.to_sym
        sub_option = args.deq

        ARGS_DATA.new(command, option, sub_option)
      end

      def parse_args
        result = Queue.new

        arguments.each do |arg|
          result.enq arg
        end

        result
      end
    end
  end
end
