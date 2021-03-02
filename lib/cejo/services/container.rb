# frozen_string_literal: true

module Cejo
  # Utilities and System Software front-end.
  module Services
    # Simple isolation provider of services
    class Container
      attr_reader :stored

      def initialize
        @stored = {}
      end

      public

      def register(name, obj)
        stored.store(name, obj)
      end

      def resolve(name)
        stored[name]
      end
    end
  end
end
