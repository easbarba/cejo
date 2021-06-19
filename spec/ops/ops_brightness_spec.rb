# frozen_string_literal: true

require 'cejo'

require 'spec_helper'

module Cejo
  RSpec.describe 'Brightness' do
    context 'has the action' do
      let(:base) { Cejo::Ops::Brightness.new('down') }

      it 'has the final_command' do
        step = Cejo::Ops::Brightness::STEP
        expect(base.action).to eq("set #{step}%-")
      end
    end
  end
end
