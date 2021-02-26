require_relative '../../lib/cejo/sections/distro/need'

require 'spec_helper'

RSpec.describe 'The needs of one' do
  it 'it needs to be admin' do
    need = Cejo::Distro::Need.new(:install)
    expect(need.admin?).to eq(true)
  end

  it 'it needs arguments' do
    need = Cejo::Distro::Need.new(:install)
    expect(need.arguments?).to eq(true)
  end

  it 'it accepts whatever you wish, arguments or no' do
    need = Cejo::Distro::Need.new(:autoremove)
    expect(need.whatever?).to eq(true)
  end
end
