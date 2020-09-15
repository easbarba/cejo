# frozen_string_literal: true

module Cero
  module Client
    # Return Operations Modules
    class ProjectsClient
      attr_reader :git, :action

      def initialize(git, action)
        @git = git
        @action = action.deq
        p @action
      end

      def oss
        oss = Cero::Projects::Oss.new(@git)
        oss.run(action)
      end

      def modules
        {
          oss: oss
        }
      end
    end
  end
end
