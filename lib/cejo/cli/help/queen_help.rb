# frozen_string_literal: true

require 'colorize'
require 'terminal-table'

module Cejo
  # Process CLI arguments.
  module CLI
    # Inform user about Hives and commands available
    module Help
      class QueenHelp
        attr_reader :section, :feature

        def initialize(section, feature)
          @section = section
          @feature = feature
        end

        def sections
          {
            floss: FlossHelp.new,
            projects: ProjectsHelp.new,
            distro: DistroHelp.new,
            media: MediaHelp.new,
            ops: OpsHelp.new,
          }
        end

        def section_available?
          sections.key?(section)
        end

        def feature_available?
          sections[section].features.key?(feature)
        end

        def validate
          # section
          show_sections if section.nil? #&& section['help']
          show_sections unless section_available?
          # features
          show_features if feature.nil? #&& feature['help']
          show_features unless feature_available?
        end

        def show_sections
          puts 'Sections available:\n'
          rows = []
          sections.each do |key, section|
            rows << [key, section.description]
          end
          table = Terminal::Table.new(:headings => ['Section', 'Description'], :rows => rows)
          puts table
          exit!
        end

        def show_features
          puts 'Features available:\n'
          rows = []
          sections[section].features.each do |name, feature|
            rows << [name, feature[:desc], feature[:arguments]]
          end
          table = Terminal::Table.new(:headings => ['Feature', 'Description', 'Arguments'], :rows => rows)
          puts table
          exit!
        end
      end
    end
  end
end
