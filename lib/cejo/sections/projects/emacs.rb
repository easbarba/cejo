# frozen_string_literal: true

require 'pathname'

module Cejo
  module Projects
    # GNU Emacs Editor
    class Emacs
      attr_reader :builder, :services

      def initialize(services)
        @services = services
        @builder = Builder.new(services.resolve(:folders), services.resolve(:utils), 'emacs')
      end

      public

      def run
        builder.run
      end
    end
  end
end
