# frozen_string_literal: true

module Cejo
  module CLI
    module Help
      class OpsHelp
        def commands
          self.methods(false).to_a
        end

        def volume
          {
            command: 'Volume',
            desc: 'Manage System Volume',
            arguments: '[up, down, toggle]'
          }
        end

        def homey
          {
            command: 'homey',
            desc: 'Mirror user DATA partition folders to $HOME',
            arguments: '</folder/path/'
          }
        end

        def dots
          {
            command: 'Brightness',
            desc: 'Mirror Lar files in $HOME.',
            arguments: '</folder/path/'
          }
        end

        def sysinfo
          {
            command: 'sysinfo',
            desc: 'Display System Hardware Information.',
            arguments: nil
          }
        end

        def screenshot
          {
            command: 'screenshot',
            desc: 'Take a shot of the marvelous screen',
            arguments: '</folder/path/'
          }
        end

        def brightness
          {
            command: 'Brightness',
            desc: 'Manage System brightness.',
            arguments: '[up down]'
          }
        end
      end
    end
  end
end
