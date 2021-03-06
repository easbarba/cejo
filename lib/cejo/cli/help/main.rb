# frozen_string_literal: true

require 'colorize'

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
          return unless section.nil?

          puts 'Sections available:'
          sections.each do |key, section|
            puts "   #{key}: #{section.description}"
          end

          exit!
        end

        def show_features
          return unless feature.nil?
          print section.capitalize.to_s.bold.red
          puts

          print "    ", "Name".bold, "                ", "Description".bold, "                          ", "Arguments"
          puts

          sections[section].features.each do |name, feature|
            print "    ", name.to_s.bold.blue, ":           ", "#{feature[:desc]}", "        ", "#{feature[:arguments]}".green
            puts
          end

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
