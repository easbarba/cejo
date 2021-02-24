# frozen_string_literal: true

require_relative 'super_user'
require_relative 'current_packager'

module Cejo
  # Distro Front End
  module Distro
    # Base
    class Base
      attr_reader :services, :action, :arguments

      def initialize(services, action, arguments)
        @services = services
        @arguments = arguments
        @action = action
      end

      def run
        packer = Cejo::Distro::CurrentPackager.new.packager(services.utils)

        super_or_not = Cejo::Distro::SuperUser.new.needed?(action)
        super_user = super_or_not ? 'sudo' : ''

        cmd = "#{super_user} #{packer} #{action} #{arguments}"

        system(cmd)
      end
    end
  end
end
