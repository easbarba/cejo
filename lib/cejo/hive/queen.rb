# frozen_string_literal: true

module Cejo
  module Hive
    # Provide Hives
    class Queen
      attr_reader :services, :sub_option

      private

      def initialize(services, sub_option)
        @services = services
        @sub_option = sub_option
      end

      def ops
        OpsHive.new(services, sub_option)
      end

      def floss
        FlossHive.new(services, sub_option)
      end

      def media
        MediaHive.new(services, sub_option)
      end

      def projects
        ProjectsHive.new(services)
      end

      def di
        DistroHive.new(services, sub_option)
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
