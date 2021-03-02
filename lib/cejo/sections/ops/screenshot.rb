# frozen_string_literal: true

require 'date'

module Cejo::Ops
  # Symlink Dotfiles to $HOME
  class Screenshot
    attr_reader :utils

    private

    def initialize(utils)
      @utils = utils
    end

    def shotters
      { scrot: '', maim: '' }
    end

    def shotter_avaiable
      shotters.keys.first { |shotter| utils.which?(shotter) }
    end

    def current_time
      Time.new.strftime('%d-%m-%Y-%k:%M')
    end

    def screen_folder
      Pathname.new(Dir.home).join('Pictures')
    end

    def screen_name
      "screenshot-#{current_time}.png"
    end

    public

    def run_args
      "#{shotter_avaiable} #{screen_name}"
    end

    def run
      Dir.chdir(screen_folder) { system(run_args) }
    end
  end
end
