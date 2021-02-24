# frozen_string_literal: true

module Cejo
  module Client
    # List Projects To build
    class ProjectsClient
      attr_reader :services, :sub_option

      private

      def initialize(services, sub_option)
        @services = services
        @sub_option = sub_option
      end

      def emacs
      end


      public

      def features
        {emacs: emacs}
      end
    end
  end
end
