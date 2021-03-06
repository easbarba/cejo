# frozen_string_literal: true

module Cejo
  module CLI
    module Help
      class FlossHelp
        attr_reader :feature

        def initialize
        end

        def description
          'Brought to you by Flossy Vanities'.freeze
        end

        def features
          self.methods(false).to_a
        end

        def grab
          {
            command: 'grab',
            desc: 'Grab FLOSS Projects',
            arguments: nil
          }
        end

        def archive
          {
            command: 'Archive',
            desc: 'Archive FLOSS Projects',
            arguments: nil
          }
        end
      end
    end
  end
end
