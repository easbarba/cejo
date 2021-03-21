# frozen_string_literal: true

module Cejo
  module CLI
    module Help
      class ProjectsHelp
        attr_reader :description

        def initialize
          @description = 'List Projects To build'.freeze
        end

        public

        def emacs
          {
            desc: 'GNU Emacs Editor',
            arguments: nil,
          }
        end

        def st
          {
            desc: 'Suckless Terminal',
            arguments: nil,
          }
        end

        def dwm
          {
            desc: 'Suckless window manager',
            arguments: nil,
          }
        end

        def ruby
          {
            desc: 'Ruby Programming language',
            arguments: nil,
          }
        end

        def features
          self.methods - self.class.superclass.instance_methods
        end
      end
    end
  end
end
