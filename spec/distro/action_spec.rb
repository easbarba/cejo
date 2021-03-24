# frozen_string_literal: true

require 'cejo'

require 'spec_helper'

RSpec.describe 'The marvelous Distro' do
  context 'Current Packager' do
    let(:action) { Cejo::Distro::TranslateAction.new }

    it 'has the real action' do
      commands = {
        apt: { autoremove: 'autoremove' },
        dnf: { autoremove: 'autoremove' },
      }
      real_action = action.real_action(commands, :dnf, :autoremove)

      expect(real_action).to eq('autoremove')
    end
  end
end
