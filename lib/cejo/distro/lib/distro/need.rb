# frozen_string_literal: true

module Cejo
  module Distro
    # Base
    class Need
      attr_reader :action

      ADMIN = %i[install remove purge update upgrade clean autoremove].freeze
      ARGUMENTS = %i[install remove purge dependencies].freeze
      WHATEVER = %i[autoremove].freeze

      def initialize(action)
        @action = action
      end

      # Action need to be run with administration level
      def admin?
        true if ADMIN.include? action
      end

      # Action need any argument
      def arguments?
        true if ARGUMENTS.include? action
      end

      def whatever?
        true if WHATEVER.include? action
      end
    end
  end
end