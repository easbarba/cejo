# frozen_string_literal: true

# Get Cli Arguments
module Cero
  module Cli
    class Arguments
      def grab_guments(arguments)
        args = Queue.new

        arguments.each do |arg|
          args << arg
        end

        args
      end
    end
  end
end
