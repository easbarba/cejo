# frozen_string_literal: true

require 'cejo'

require 'spec_helper'

module Cejo
  RSpec.describe 'The awesome screenshot' do
    utils = Class.new do
      def which?(_)
        ['flameshot']
      end
    end.new

    let(:screen) { Cejo::Ops::Screenshot.new(utils, :full) }

    it 'shotter available' do
      expect(screen.shotters_available.first[:bin]).to eq('flameshot')
    end

    it 'has the final_command' do
      expect(screen.final_command).to eq("flameshot full -p #{Dir.home}/Pictures")
    end
  end
end
