# frozen_string_literal: true

module Cejo::Distro
  # Base
  class SuperUser
    def needed?(action)
      yep = %w[install remove purge update upgrade clean autoremove]
      nope = %w[dependencies]

      return yep.include?(action) ? true : false
    end
  end
end
