# frozen_string_literal: true

require_relative '../../sections/projects/builder'
require_relative '../../sections/projects/emacs'
require_relative '../../sections/projects/dwm'
require_relative '../../sections/projects/ruby'

module Cejo
  module Client
    # List Projects To build
    class ProjectsClient
      attr_reader :services

      def initialize(services)
        @services = services
      end

      def emacs
        builder = Projects::Builder.new(services.folders, services.utils)
        Projects::Emacs.new(builder)
      end

      def dwm
        builder = Projects::Builder.new(services.folders, services.utils)
        Projects::Dwm.new(builder)
      end

      def ruby
        builder = Projects::Builder.new(services.folders, services.utils)
        Projects::Ruby.new(builder)
      end

      public

      def features
        {
          dwm: dwm,
          emacs: emacs,
          ruby: ruby
        }
      end
    end
  end
end
