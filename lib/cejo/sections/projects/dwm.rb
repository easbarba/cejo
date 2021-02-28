# frozen_string_literal: true

require "pathname"

module Cejo
  module Projects
    # Suckless Dwm
    class Dwm
      attr_reader :builder

      def initialize(builder)
        builder.project = "dwm"
        @builder = builder
      end

      public

      def run
        builder.run
      end
    end
  end
end
