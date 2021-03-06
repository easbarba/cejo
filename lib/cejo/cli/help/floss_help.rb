# frozen_string_literal: true

module Cejo
  module CLI
    module Help
      class FlossHelp
        attr_reader :description

        def initialize
          @description = 'Brought to you by Flossy Vanities'.freeze
        end

        def grab
          {
            name: 'Grab',
            desc: 'Grab FLOSS Projects',
            arguments: nil
          }
        end

        def archive
          {
            name: 'Archive',
            desc: 'Archive FLOSS Projects',
            arguments: nil
          }
        end

        def features
          {
            archive: archive,
            grab: grab
          }
        end
      end
    end
  end
end
