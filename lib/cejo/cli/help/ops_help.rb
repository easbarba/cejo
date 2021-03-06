# frozen_string_literal: true

module Cejo
  module CLI
    module Help
      class OpsHelp
        attr_reader :description

        def initialize
          @description = 'System operations front-end'.freeze
        end

        def volume
          {
            name: 'Volume',
            desc: 'Manage System Volume',
            arguments: '[up, down, toggle]'
          }
        end

        def homey
          {
            name: 'homey',
            desc: 'Mirror user DATA partition folders to $HOME',
            arguments: '</folder/path/'
          }
        end

        def dots
          {
            name: 'Brightness',
            desc: 'Mirror Lar files in $HOME.',
            arguments: '</folder/path/'
          }
        end

        def sysinfo
          {
            name: 'sysinfo',
            desc: 'Display System Hardware Information.',
            arguments: nil
          }
        end

        def screenshot
          {
            name: 'screenshot',
            desc: 'Take a shot of the marvelous screen',
            arguments: '</folder/path/'
          }
        end

        def brightness
          {
            name: 'Brightness',
            desc: 'Manage System brightness.',
            arguments: '[up down]'
          }
        end

        def features
          {
            brightness: brightness,
            screenshot: screenshot,
            sysinfo: sysinfo,
            dots: dots,
            volume: volume,
            homey: homey
          }
        end
      end
    end
  end
end
