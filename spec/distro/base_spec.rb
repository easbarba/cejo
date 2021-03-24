# frozen_string_literal: true

require 'cejo'

require 'spec_helper'

RSpec.describe 'The marvelous Distro' do
  context 'Current Packager' do
    let(:base) { Cejo::Distro::Base.new(folders, utils) }
    let(:arguments) { 'fonts-hack' }
    let(:folders) { Pathname.new '/home/engels/.config/cejo' }

    let(:utils) {
      Class.new do
        def which?(x)
          true
        end

        def parse_folder(x)
          { apt: { install: 'install' } }
        end
      end.new
    }

    it 'has action argument as symbol' do
      base.action = :search
      base.arguments = 'fonts-hack'
      expect(base.action).to eq(:search)
    end

    it 'has string arguments' do
      base.action = :install
      base.arguments = arguments
      expect(base.arguments).to eq(arguments)
    end

    it 'has does not have arguments' do
      base.action = :update
      base.arguments = nil
      expect(base.arguments).to eq(nil)
    end

    it 'has the translated action' do
      base.action = :install
      base.arguments = arguments
      expect(base.real_action).to eq('install')
    end

    it 'has the commands' do
      base.action = :install
      base.arguments = arguments
      expect(base.commands).to eq(base.utils.parse_folder(''))
    end

    it 'use the correct pakager' do
      base.action = :install
      base.arguments = arguments
      expect(base.packager).to eq(:apt)
    end

    it 'has the final_command' do
      base.action = :install
      base.arguments = arguments
      expect(base.final_command).to eq('sudo apt install fonts-hack')
    end
  end
end
