require_relative '../lib/cejo/sections/distro/commands'

require 'spec_helper'

RSpec.describe 'The marvelous distro' do
  let(:commands) { Cejo::Distro::Commands.new }

  context "What about the Commands?" do
    it "it has at least one packager commands set!" do
      install = commands.all.first[1][:install]
      expect(install).to eq("install")
    end
  end
end
