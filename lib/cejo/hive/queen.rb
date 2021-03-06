# frozen_string_literal: true

module Cejo
  module Hive
    # Provide Hives
    class Queen
      attr_reader :services, :arguments

      private

      def initialize(services, arguments)
        @services = services
        @arguments = arguments
      end

      def ops
        OpsHive.new(services, arguments)
      end

      def floss
        FlossHive.new(services, arguments)
      end

      def media
        MediaHive.new(services, arguments)
      end

      def projects
        ProjectsHive.new(services)
      end

      def di
        DistroHive.new(services, arguments)
      end

      public

      ## Return available sections.
      def sections
        {
          media: media,
          ops: ops,
          projects: projects,
          di: di,
          floss: floss
        }
      end
    end
  end
end
