# frozen_string_literal: true

require "pathname"

module Cejo
  module Projects
    # GNU Emacs Editor
    class Emacs
      attr_reader :builder

      def initialize(builder)
        builder.project = "emacs"
        @builder = builder
      end

      public

      def run
        builder.run
      end
    end
  end
end
