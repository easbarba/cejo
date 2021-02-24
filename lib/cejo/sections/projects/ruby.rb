# frozen_string_literal: true

require_relative 'core'

require "pathname"

module Cejo
  # Build Floss Projects
  module Projects
    # Ruby Programming language
    class Ruby
      attr_reader :services

      def initialize(services)
        @services = services
      end

      public

      def run
        Cejo::Projects::Core.new(services, 'ruby').run
      end
    end
  end
end
