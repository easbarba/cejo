# frozen_string_literal: true

require_relative 'core'

require "pathname"

module Cejo::Projects
  # Suckless Dwm
  class Dwm
    attr_reader :services

    def initialize(services)
      @services = services
    end

    public

    def run
      Cejo::Projects::Core.new(services, 'dwm').run
    end
  end
end
