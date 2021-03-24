# frozen_string_literal: true

require 'cejo'

require 'spec_helper'

RSpec.describe 'The marvelous Distro' do
  it 'needs to be admin' do
    need = Cejo::Distro::Need.new(:install)
    expect(need.admin?).to eq(true)
  end

  it 'needs arguments' do
    need = Cejo::Distro::Need.new(:install)
    expect(need.arguments?).to eq(true)
  end

  it 'accepts whatever you wish, arguments or no' do
    need = Cejo::Distro::Need.new(:autoremove)
    expect(need.whatever?).to eq(true)
  end
end
