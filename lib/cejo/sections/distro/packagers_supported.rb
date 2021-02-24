# frozen_string_literal: true

module Cejo
  module Distro
    # List of Supported Packagers
    module PackagersSupported
      ALL = [ 'apt', 'dnf', 'emerge', 'nix', 'guix', 'pkg' ]
    end
  end
end
