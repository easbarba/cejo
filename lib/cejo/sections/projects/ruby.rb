# frozen_string_literal: true

require "pathname"

module Cejo
  module Projects
    # Ruby Programming language
    class Ruby
      attr_reader :builder

      def initialize(builder)
        builder.project = "ruby"
        @builder = builder
      end

      public

      def run
        builder.run
      end
    end
  end
end
