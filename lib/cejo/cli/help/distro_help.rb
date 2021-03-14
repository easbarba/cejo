# frozen_string_literal: true

module Cejo
  module CLI
    module Help
      class DistroHelp
        attr_reader :description

        def initialize
          @description = 'Distro Commands'.freeze
        end

        private

        def install
          {
            name: 'Install',
            desc: 'Install a Package from Repositories',
            arguments: '<arguments>',
          }
        end

        def remove
          {
            name: 'Remove',
            desc: 'Remove One or More Installed Packages',
            arguments: '<arguments>',
          }
        end

        def search
          {
            name: 'Search',
            desc: 'Find a Package',
            arguments: '<arguments>',
          }
        end

        def upgrade
          {
            name: 'Upgrade',
            desc: 'Upgrade Installed Packages',
            arguments: '<arguments>',
          }
        end

        def update
          {
            name: 'Update',
            desc: 'Update Package Lists',
            arguments: '<arguments>',
          }
        end

        def clean
          {
            name: 'Clean',
            desc: 'Clean system residual packages dependencies',
            arguments: '<arguments>',
          }
        end

        def download
          {
            name: 'Download',
            desc: 'Download package binary',
            arguments: '<arguments>',
          }
        end

        def installed
          {
            name: 'Installed',
            desc: 'List installed packages',
            arguments: '<arguments>',
          }
        end

        def info
          {
            name: 'Info',
            desc: 'View Info About a Specific Package',
            arguments: '<arguments>',
          }
        end

        def fix
          {
            name: 'Fix',
            desc: 'Fix system issues',
            arguments: '<arguments>',
          }
        end

        public

        def features
          {
            fix: fix,
            info: info,
            installed: installed,
            install: install,
            search: search,
            remove: remove,
            update: update,
            upgrade: upgrade,
            download: download,
            clean: clean,
          }
        end
      end
    end
  end
end
