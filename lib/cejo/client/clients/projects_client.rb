# frozen_string_literal: true

require_relative '../../sections/projects/emacs'
require_relative '../../sections/projects/dwm'

module Cejo
  module Client
    # List Projects To build
    class ProjectsClient
      attr_reader :services

      def initialize(services)
        @services = services
      end

      def emacs
        Projects::Emacs.new(services)
      end

      def dwm
        Projects::Dwm.new(services)
      end

      public

      def features
        {
          emacs: emacs,
          dwm: dwm
        }
      end
    end
  end
end
