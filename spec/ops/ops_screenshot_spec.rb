# frozen_string_literal: true

require 'cejo'

require 'spec_helper'

RSpec.describe 'The awesome screenshot' do
  utils = Class.new do
    def which?(_)
      ['flameshot']
    end
  end.new

  let(:screen) { Cejo::Ops::Screenshot.new(utils, :full) }

  it 'shotter available' do
    expect(screen.shotters_available).to eq('.')
  end

  it 'has the final_command' do
    expect(screen.final_command).to eq('.')
  end
end
