# frozen_string_literal: true

require_relative '../../sections/operations/oss.rb'

module Cero
  module Client
    # Return Operations Modules
    class OperationsClient
      attr_reader :git

      def initialize(git)
        @git = git
      end

      def oss
        oss = Oss.new(@git)
        oss.run('get')
      end
    end
  end
end
