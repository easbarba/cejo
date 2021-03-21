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
            description: 'Install a Package from Repositories',
            arguments: '<arguments>',
          }
        end

        def autoremove
          {
            description: 'Remove One or More Installed Packages',
            arguments: '<arguments>',
          }
        end

        def remove
          {
            description: 'Remove One or More Installed Packages',
            arguments: '<arguments>',
          }
        end

        def search
          {
            description: 'Find a Package',
            arguments: '<arguments>',
          }
        end

        def upgrade
          {
            description: 'Upgrade Installed Packages',
            arguments: '<arguments>',
          }
        end

        def update
          {
            description: 'Update Package Lists',
            arguments: '<arguments>',
          }
        end

        def clean
          {
            description: 'Clean system residual packages dependencies',
            arguments: '<arguments>',
          }
        end

        def download
          {
            description: 'Download package binary',
            arguments: '<arguments>',
          }
        end

        def installed
          {
            description: 'List installed packages',
            arguments: '<arguments>',
          }
        end

        def info
          {
            description: 'View Info About a Specific Package',
            arguments: '<arguments>',
          }
        end

        def fix
          {
            description: 'Fix system issues',
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
