# frozen_string_literal: true

require "pathname"

module Cejo
  module Projects
    # Suckless Dwm
    class Dwm
      attr_reader :builder, :services

      def initialize(services)
        @services = services
        @builder = Projects::Builder.new(services.folders, services.utils, "dwm")      end

      public

      def run
        builder.run
      end
    end
  end
end
