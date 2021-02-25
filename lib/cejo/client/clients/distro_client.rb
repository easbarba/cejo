# frozen_string_literal: true

require_relative '../../sections/distro/base'

module Cejo
  module Client
    # Distro Clients
    class DistroClient
      attr_reader :services, :arguments

      private

      def initialize(services, arguments)
        @services = services
        @arguments = arguments
      end

      def install
        Distro::Base.new(services, 'install', arguments)
      end

      def remove
        Distro::Base.new(services, 'remove', arguments)
      end

      def upgrade
        Distro::Base.new(services, 'upgrade', arguments)
      end

      def autoremove
        Distro::Base.new(services, 'autoremove', arguments)
      end

      def update
        Distro::Base.new(services, 'update', arguments)
      end

      def clean
        Distro::Base.new(services, 'clean', arguments)
      end

      public

      def features
        {
          i: install,
          r: remove,
          ug: upgrade,
          ud: update,
          c: clean,
          au: autoremove
        }
      end
    end
  end
end
