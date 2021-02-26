# frozen_string_literal: true

module Cejo::Distro
  # Base
  class Action
    attr_reader :services, :action

    def initialize(services, action)
      @services = services
      @action = action
    end

    def real_action(packager)
      packager = packager.to_sym
      packagers_commands[packager][action]
    end
  end
end
