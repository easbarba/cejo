# frozen_string_literal: true

module Cejo
  class CLI
    # Process CLI arguments.
    module Base
      ARGS = Struct.new(:command, :option, :sub_option)

      def self.arguments(arguments)
        args = parse_args(arguments)

        command = args.deq unless args.empty?
        option = args.deq unless args.empty?
        sub_option = args.deq unless args.empty?

        ARGS.new(command.to_sym, option.to_sym, sub_option)
      end

      def self.parse_args(arguments)
        args = Queue.new

        arguments.each do |arg|
          args.enq arg
        end

        args
      end
    end
  end
end
