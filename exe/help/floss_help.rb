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
            description: 'Grab FLOSS Projects',
            arguments: nil,
          }
        end

        def archive
          {
            description: 'Archive FLOSS Projects',
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
