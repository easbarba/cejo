# frozen_string_literal: true

module Cejo
  module Hive
    # Provide Hives
    class Queen
      attr_reader :services, :arguments

      def initialize(services, arguments)
        @services = services
        @arguments = arguments
      end

      public

      # Return available sections.
      def sections
        {
          media: MediaHive.new(services, arguments),
          ops: OpsHive.new(services, arguments),
          projects: ProjectsHive.new(services),
          distro: DistroHive.new(services, arguments),
          floss: FlossHive.new(services, arguments),
        }
      end
    end
  end
end
