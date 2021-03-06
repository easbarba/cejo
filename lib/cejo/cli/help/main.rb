# frozen_string_literal: true

require 'colorize'
require 'terminal-table'

module Cejo
  # Process CLI arguments.
  module CLI
    # Inform user about sections and commands available
    module Help
      class Main
        attr_reader :section, :feature

        def initialize(section, feature)
          @section = section
          @feature = feature
        end

        def sections
          {
            floss:    Cejo::CLI::Help::FlossHelp.new,
            projects: Cejo::CLI::Help::ProjectsHelp.new,
            distro:   Cejo::CLI::Help::DistroHelp.new,
            media:    Cejo::CLI::Help::MediaHelp.new,
            ops:      Cejo::CLI::Help::OpsHelp.new
          }
        end

        def show_sections
          return unless section.nil? or section =~ /(help+)/i

          puts 'Sections available:'
          rows = []
          sections.each do |key, section|
            rows << [key, section.description]
          end

          table = Terminal::Table.new :headings => ['Feature', 'Description'], :rows => rows
          puts table

          exit!
        end

        def show_features
          return unless feature.nil? or feature =~ /(help+)/i

          print section.capitalize.to_s.bold.red
          puts

          rows = []
          sections[section].features.each do |name, feature|
            rows << [name, feature[:desc], feature[:arguments]]
          end

          table = Terminal::Table.new :headings => ['Feature', 'Description', 'Arguments'], :rows => rows
          puts table

          exit!
        end

        def validate
          show_sections
          show_features
        end
      end
    end
  end
end
