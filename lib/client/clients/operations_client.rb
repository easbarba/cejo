# frozen_string_literal: true

require_relative '../../sections/operations/oss.rb'

module Cero
  module Client
    # Return Operations Modules
    class OperationsClient
      attr_reader :git, :action

      def initialize(git, action)
        @git = git
        @action = action.deq
      end

      def oss
        oss = Cero::Operations::Oss.new(@git)
        oss.run(@action)
      end

      def modules
        {
          oss: oss
        }
      end
    end
  end
end
