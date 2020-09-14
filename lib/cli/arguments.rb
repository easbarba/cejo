# frozen_string_literal: true

module Cero
  module Cli
    # Get Cli Arguments
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
