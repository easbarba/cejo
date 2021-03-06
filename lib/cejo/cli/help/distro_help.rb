# frozen_string_literal: true

module Cejo
  module CLI
    module Help
      class DistroHelp
        def initialize
        end

        def description
          'Distro Commands'.freeze
        end

        def features
          self.methods(false).to_a
        end

        def install
          {
            command: 'Install',
            desc: 'Install a Package from Repositories',
            arguments: '<arguments>',
          }
        end

        def remove
          {
            command: 'Remove',
            desc: 'Remove One or More Installed Packages',
            arguments: '<arguments>',
          }
        end

        def search
          {
            command: 'Search',
            desc: 'Find a Package',
            arguments: '<arguments>',
          }
        end

        def upgrade
          {
            command: 'Upgrade',
            desc: 'Upgrade Installed Packages',
            arguments: '<arguments>',
          }
        end

        def update
          {
            command: 'Update',
            desc: 'Update Package Lists',
            arguments: '<arguments>',
          }
        end

        def clean
          {
            command: 'Clean',
            desc: '',
            arguments: '<arguments>',
          }
        end

        def download
          {
            command: 'Download',
            desc: '',
            arguments: '<arguments>',
          }
        end

        def installed
          {
            command: 'Installed',
            desc: '',
            arguments: '<arguments>',
          }
        end

        def info
          {
            command: 'Info',
            desc: 'View Info About a Specific Package',
            arguments: '<arguments>',
          }
        end

        def fix
          {
            command: 'Fix',
            desc: '',
            arguments: '<arguments>',
          }
        end
      end
    end
  end
end
