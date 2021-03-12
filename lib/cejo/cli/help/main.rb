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
            di:       Cejo::CLI::Help::DistroHelp.new,
            media:    Cejo::CLI::Help::MediaHelp.new,
            ops:      Cejo::CLI::Help::OpsHelp.new
          }
        end

        def section_available?
          sections.key? section
        end

        def feature_available?
          sections[section].features.key? feature
        end

        def validate
          show_sections if section.nil? #or section =~ /(help+)/i
          show_sections unless section_available?

          show_features if feature.nil? #or feature =~ /(help+)/i
          show_features unless feature_available?
        end

        def show_sections
          puts 'Sections available:'
          puts

          rows = []
          sections.each do |key, section|
            rows << [key, section.description]
          end

          table = Terminal::Table.new :headings => ['Section', 'Description'], :rows => rows
          puts table

          exit!
        end

        def show_features
          puts 'Features available:'
          puts

          rows = []
          sections[section].features.each do |name, feature|
            rows << [name, feature[:desc], feature[:arguments]]
          end

          table = Terminal::Table.new :headings => ['Feature', 'Description', 'Arguments'], :rows => rows
          puts table

          exit!
        end
      end
    end
  end
end
