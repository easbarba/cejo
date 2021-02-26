# frozen_string_literal: true

module Cejo
  module Distro
    # Translate Raw Action
    class Action
      # Translated action
      def real_action(commands, packager, action)
        commands[packager][action]
      end
    end
  end
end
