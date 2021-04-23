# frozen_string_literal: true

require 'pathname'

module Cejo
  module Media
    # Parse information using grabber
    class GrabberParser
      def info(current, fmt, url)
        result = "#{current.name} #{current.parser} '#{fmt}' #{url}"

        `#{result}`.strip
      end
    end
  end
end
