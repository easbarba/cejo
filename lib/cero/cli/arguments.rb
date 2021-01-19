# frozen_string_literal: true

module Cero
  module Cli
    # Process CLI arguments.
    class Arguments
      def grab_arguments(arguments)
        args = Queue.new

        arguments.each do |arg|
          args.enq arg
        end

        args
      end
    end
  end
end
