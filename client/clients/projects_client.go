# frozen_string_literal: true

module Cero
  module Client
    # Projects features
    class ProjectsClient
      attr_reader :services, :command

      private

      def initialize(services, command)
        @services = services
        @command = command
      end

      public

      def features
        {}
      end
    end
  end
end
