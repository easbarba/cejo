# frozen_string_literal: true

require 'pathname'

module Cejo
  module Media
    # Parse information using grabber
    class GrabberParser
      def info(current, fmt, url)
        current_fmt = current.instance_eval "current.#{fmt}"
        result = "#{current.name} #{current.parser} '#{current_fmt}' #{url}"

        `#{result}`.strip
      end
    end
  end
end
