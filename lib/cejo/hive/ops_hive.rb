# frozen_string_literal: true

module Cejo
  module Hive
    # System operations front-end
    class OpsHive
      attr_reader :argument, :utils

      private

      def initialize(services, argument)
        @utils = services.resolve(:utils)
        @argument = argument.first if argument
      end

      public

      def features
        {
          brightness: Ops::Brightness.new(utils, argument),
          dots: Ops::Dots.new(utils, argument),
          volume: Ops::Volume.new(utils, argument),
          screenshot: Ops::Screenshot.new(utils),
          sysinfo: Ops::Sysinfo.new(utils, argument),
          homey: Ops::Homey.new(argument),
        }
      end
    end
  end
end
