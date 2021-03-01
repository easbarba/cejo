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
        Projects::Emacs.new(services)
      end

      def dwm
        Projects::Dwm.new(services)
      end

      def ruby
        Projects::Ruby.new(services)
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
