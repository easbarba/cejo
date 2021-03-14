# frozen_string_literal: true

module Cejo
  module Hive
    # List Projects To build
    class ProjectsHive
      attr_reader :services

      def initialize(services)
        @services = services
      end

      public

      def features
        {
          dwm: Projects::Dwm.new(services),
          emacs: Projects::Emacs.new(services),
          ruby: Projects::Ruby.new(services),
          st: Projects::St.new(services),
        }
      end
    end
  end
end
