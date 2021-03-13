# frozen_string_literal: true

require "pathname"

module Cejo
  module Projects
    # Ruby Programming language
    class Ruby
      attr_reader :builder, :services

      def initialize(services)
        @services = services
        @builder = Builder.new(services.resolve(:folders), services.resolve(:utils), "ruby")
      end

      public

      def run
        builder.run
      end
    end
  end
end
