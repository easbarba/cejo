# frozen_string_literal: true

require_relative 'packagers_supported'

module Cejo::Distro
  # Base
  class CurrentPackager
    def packager(utils)
      PackagersSupported::ALL.find do
        |x| utils.has_program?(x)
      end.to_sym
    end
  end
end
