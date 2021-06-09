# frozen_string_literal: true

require 'cejo'

require 'spec_helper'

module Cejo
  module Distro
    RSpec.describe 'Distro - the marvelous action' do
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
  end
end
