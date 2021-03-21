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
            description: 'Manage System Volume',
            arguments: '[up, down, toggle]',
          }
        end

        def homey
          {
            description: 'Mirror user DATA partition folders to $HOME',
            arguments: '</folder/path/',
          }
        end

        def dots
          {
            description: 'Mirror Lar files in $HOME.',
            arguments: '</folder/path/',
          }
        end

        def sysinfo
          {
            description: 'Display System Hardware Information.',
            arguments: nil,
          }
        end

        def screenshot
          {
            description: 'Take a shot of the marvelous screen',
            arguments: '</folder/path/',
          }
        end

        def brightness
          {
            description: 'Manage System brightness.',
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
