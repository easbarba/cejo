# frozen_string_literal: true

module Cejo::Distro
  # Base
  class ParsedAction
    attr_reader :services, :action

    def initialize(services, action)
      @services = services
      @action = action
    end

    def folder
      services.folders.cejo_config.join('distro')
    end

    def commands
      services.utils.parse_folder(folder)
    end

    def real_action(packager)
      commands[packager][action]
    end
  end
end
