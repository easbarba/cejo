# frozen_string_literal: true

module Cejo
  module CLI
    module Help
      class MediaHelp
        attr_reader :description

        def initialize
          @description = 'Manage System media features'.freeze
        end

        def play
          {
            description: 'Play file, random media in folder or with url.',
            arguments: '<url> or </path/to/file>',
          }
        end

        def get
          {
            description: 'Get media pointed in url.',
            arguments: '<url> [codec]',
          }
        end

        def features
          self.methods - self.class.superclass.instance_methods
        end
      end
    end
  end
end
