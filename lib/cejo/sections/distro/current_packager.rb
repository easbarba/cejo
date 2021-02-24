# frozen_string_literal: true

require_relative 'packagers_supported'

module Cejo::Distro
  # Base
  class CurrentPackager
    def packager(utils)
      Cejo::Distro::PackagersSupported::ALL.find do
        |x| utils.has_program?(x)
      end
    end
  end
end
