# frozen_string_literal: true

module Cejo
  module Distro
    # Base
    class Need
      YEP = %w[install remove purge update upgrade clean autoremove].freeze
      NOPE = %w[dependencies].freeze

      # Action need to be run with administration level
      def admin?(action)
        return YEP.include?(action) ? true : false
      end

      # Action need any argument
      def arguments?
        return NOPE.include?(action) ? true : false
      end
    end
  end
end
