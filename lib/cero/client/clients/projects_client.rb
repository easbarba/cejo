# frozen_string_literal: true

module Cero
  module Client
    # Return Operations Modules
    class ProjectsClient
      attr_reader :git, :action

      def initialize(git, action)
        @git = git
        @action = action.deq
      end

      def modules
        {

        }
      end
    end
  end
end
