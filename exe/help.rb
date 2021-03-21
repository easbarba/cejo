# frozen_string_literal: true

require 'colorize'
require 'terminal-table'

module Cejo
  # Inform user about Hives and commands available
  class Help
    attr_reader :section, :feature

    def initialize(section, feature)
      @section = section
      @feature = feature
    end

    def floss
      {
        description: 'Brought to you by Flossy Vanities'.freeze,
        grab: { desc: 'Grab FLOSS Projects', args: nil },
        archive: { desc: 'Archive FLOSS Projects', args: nil },
      }
    end

    def projects
      {
        description: 'List Projects To build'.freeze,
        emacs: { desc: 'GNU Emacs Editor', args: nil },
        st: { desc: 'Suckless Terminal', args: nil },
        dwm: { desc: 'Suckless window manager', args: nil },
        ruby: { desc: 'Ruby Programming language', args: nil },
      }
    end

    def media
      {
        description: 'Manage System media features'.freeze,
        play: { desc: 'Play file, random media in folder or with url.', args: '<url> or </path/to/file>' },
        get: { desc: 'Get media pointed in url.', args: '<url> [codec]' },
      }
    end

    def distro
      {
        description: 'Distro Commands'.freeze,
        install: { desc: 'Install a Package from Repositories', args: '<arguments>' },
        autoremove: { desc: 'Remove One or More Installed Packages', args: '<arguments>' },
        remove: { desc: 'Remove One or More Installed Packages', args: '<arguments>' },
        search: { desc: 'Find a Package', args: '<arguments>' },
        upgrade: { desc: 'Upgrade Installed Packages', args: '<arguments>' },
        update: { desc: 'Update Package Lists', args: '<arguments>' },
        clean: { desc: 'Clean system residual packages dependencies', args: '<arguments>' },
        download: { desc: 'Download package binary', args: '<arguments>' },
        installed: { desc: 'List installed packages', args: '<arguments>' },
        info: { desc: 'View Info About a Specific Package', args: '<arguments>' },
        fix: { desc: 'Fix system issues', args: '<arguments>' },
      }
    end

    def ops
      {
        description: 'System operations front-end'.freeze,
        volume: { desc: 'Manage System Volume', args: '[up, down, toggle]' },
        homey: { desc: 'Mirror user DATA partition folders to $HOME', args: '</folder/path/' },
        dots: { desc: 'Mirror Lar files in $HOME.', args: '</folder/path/' },
        sysinfo: { desc: 'Display System Hardware Information.', args: nil },
        screenshot: { desc: 'Take a shot of the marvelous screen', args: '</folder/path/' },
        brightness: { desc: 'Manage System brightness.', args: '[up down]' }
      }
    end

    def sections
      {
        floss: floss,
        projects: projects,
        distro: distro,
        media: media,
        ops: ops,
      }
    end

    def section_available?
      sections.key?(section)
    end

    def feature_available?
      sections[section].key?(feature)
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
      rows = []
      sections.each do |key, section|
        rows << [key, section[:description]]
      end

      table = Terminal::Table.new(:headings => ['Section', 'Description'], :rows => rows)
      puts table

      exit!
    end

    def show_features
      rows = []
      sections[section].each do |features|
        next if features.first == :description

        name = features.first.to_sym
        feature = features[1]
        desc = feature[:desc]
        args = feature[:args].nil? ? 'none' : feature[:args]

        rows << [name, desc, args]
      end
      table = Terminal::Table.new(:headings => ['Feature', 'Description', 'Arguments'], :rows => rows)
      puts table

      exit!
    end
  end
end
