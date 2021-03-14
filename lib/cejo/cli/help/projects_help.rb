# frozen_string_literal: true

module Cejo
  module CLI
    module Help
      class ProjectsHelp
        attr_reader :description

        def initialize
          @description = 'List Projects To build'.freeze
        end

        def emacs
          {
            name: 'Emacs',
            desc: 'GNU Emacs Editor',
            arguments: nil,
          }
        end

        def st
          {
            name: 'st',
            desc: 'Suckless Terminal',
            arguments: nil,
          }
        end

        def dwm
          {
            name: 'dwm',
            desc: 'Suckless window manager',
            arguments: nil,
          }
        end

        def ruby
          {
            name: 'Ruby',
            desc: 'Ruby Programming language',
            arguments: nil,
          }
        end

        def features
          {
            emacs: emacs,
            dwm: dwm,
            st: st,
            ruby: ruby,
          }
        end
      end
    end
  end
end
