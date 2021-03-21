# frozen_string_literal: true

module Cejo
  module CLI
    module Help
      class DistroHelp
        attr_reader :description

        def initialize
          @description = 'Distro Commands'.freeze
        end

        def install
          {
            desc: 'Install a Package from Repositories',
            arguments: '<arguments>',
          }
        end

        def autoremove
          {
            desc: 'Remove One or More Installed Packages',
            arguments: '<arguments>',
          }
        end

        def remove
          {
            desc: 'Remove One or More Installed Packages',
            arguments: '<arguments>',
          }
        end

        def search
          {
            desc: 'Find a Package',
            arguments: '<arguments>',
          }
        end

        def upgrade
          {
            desc: 'Upgrade Installed Packages',
            arguments: '<arguments>',
          }
        end

        def update
          {
            desc: 'Update Package Lists',
            arguments: '<arguments>',
          }
        end

        def clean
          {
            desc: 'Clean system residual packages dependencies',
            arguments: '<arguments>',
          }
        end

        def download
          {
            desc: 'Download package binary',
            arguments: '<arguments>',
          }
        end

        def installed
          {
            desc: 'List installed packages',
            arguments: '<arguments>',
          }
        end

        def info
          {
            desc: 'View Info About a Specific Package',
            arguments: '<arguments>',
          }
        end

        def fix
          {
            desc: 'Fix system issues',
            arguments: '<arguments>',
          }
        end

        public

        def features
          self.methods - self.class.superclass.instance_methods
        end
      end
    end
  end
end
