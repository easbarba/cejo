# frozen_string_literal: true

require 'pathname'

module Cejo
  module Projects
    # Suckless Terminal
    class St
      attr_reader :builder, :services

      def initialize(services)
        @services = services
        @builder = Builder.new(services.resolve(:folders), services.resolve(:utils), 'st')
      end

      public

      def run
        builder.run
      end
    end
  end
end
