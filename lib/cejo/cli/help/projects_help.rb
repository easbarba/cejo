# frozen_string_literal: true

module Cejo
  module CLI
    module Help
      class ProjectsHelp
        def commands
          self.methods(false).to_a
        end

        def emacs
          {
            command: 'Emacs',
            desc: 'GNU Emacs Editor',
            arguments: nil
          }
        end

        def dwm
          {
            command: 'dwm',
            desc: 'The suckless window manager',
            arguments: nil
          }
        end

        def ruby
          {
            command: 'Ruby',
            desc: 'Ruby Programming language',
            arguments: nil
          }
        end
      end
    end
  end
end
