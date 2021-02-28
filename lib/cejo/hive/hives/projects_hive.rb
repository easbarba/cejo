# frozen_string_literal: true

module Cejo
  module Hive
    # List Projects To build
    class ProjectsHive
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
