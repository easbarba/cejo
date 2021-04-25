# frozen_string_literal: true

require 'pathname'

module Cejo
  module Media
    # Parse information using grabber
    class Parser
      attr_reader :current, :url
      attr_accessor :fmt

      def initialize(current, url)
        @current = current
        @url = url
      end

      def new_format
        current.send fmt.to_sym
      end

      def base
        "#{current.name} #{current.parser} '#{new_format}' #{url}"
      end

      def result
        `""#{base}""`.strip
      end
      private :exec
    end
  end
end
