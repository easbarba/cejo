# frozen_string_literal: true

module Cejo::Distro
  # Base
  class Commands
    def all(raw_commands)
      raw_commands
    end

    def actions
      puts
    end

    def packagers
      all.keys
    end
  end
end
