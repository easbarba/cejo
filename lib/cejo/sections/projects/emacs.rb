# frozen_string_literal: true

require_relative 'core'

require "pathname"

module Cejo::Projects
  # GNU Emacs Editor
  class Emacs
    attr_reader :services

    def initialize(services)
      @services = services
    end

    public

    def run
      Cejo::Projects::Core.new(services, 'emacs').run
    end
  end
end
