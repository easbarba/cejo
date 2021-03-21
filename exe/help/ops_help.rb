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
            desc: 'Manage System Volume',
            arguments: '[up, down, toggle]',
          }
        end

        def homey
          {
            desc: 'Mirror user DATA partition folders to $HOME',
            arguments: '</folder/path/',
          }
        end

        def dots
          {
            desc: 'Mirror Lar files in $HOME.',
            arguments: '</folder/path/',
          }
        end

        def sysinfo
          {
            desc: 'Display System Hardware Information.',
            arguments: nil,
          }
        end

        def screenshot
          {
            desc: 'Take a shot of the marvelous screen',
            arguments: '</folder/path/',
          }
        end

        def brightness
          {
            desc: 'Manage System brightness.',
            arguments: '[up down]',
          }
        end

        def features
          self.methods - self.class.superclass.instance_methods
        end
      end
    end
  end
end
