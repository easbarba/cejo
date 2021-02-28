# frozen_string_literal: true

module Cejo::Distro
  # Base
  class Commands
    attr_reader :raw_command

    def initialize(raw_command)
      @raw_command = raw_command
    end

    def all
      raw_command
    end

    def actions
      puts
    end

    def packagers
      all.keys
    end
  end
end
