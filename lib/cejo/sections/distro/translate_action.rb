# frozen_string_literal: true

module Cejo
  module Distro
    class TranslateAction
      def real_action(commands, packager, action)
        commands[packager][action]
      end
    end
  end
end
