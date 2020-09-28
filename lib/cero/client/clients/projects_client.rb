# frozen_string_literal: true

module Cero
  module Client
    # Projects features
    class ProjectsClient
      attr_reader :services, :action

      private

      def initialize(services, action)
        @services = services
        @action = action.nil? ? nil : action
      end

      # public

      # def features
      #   {

      #   }
      # end
    end
  end
end
