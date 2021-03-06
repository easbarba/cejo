# frozen_string_literal: true

module Cejo
  module CLI
    module Help
      class MediaHelp
        def initialize
        end

         def description
           'Manage System media features'.freeze
         end

        def features
          self.methods(false).to_a
        end

        def play
          {
            command: 'Play',
            desc: 'Play file, random media in folder or with url provided by clipboard text.',
            arguments: '<url> or <path/to/file>'
          }
        end

        def get
          {
            command: 'Get',
            desc: 'Get media provided in clipboard or arguments.',
            arguments: '<media> [codec]'
          }
        end
      end
    end
  end
end
