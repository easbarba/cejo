# frozen_string_literal: true

require_relative '../../../lib/cejo'

require 'spec_helper'

module Cejo
  RSpec.describe 'Players' do
    let(:player) { Cejo::Media::Players.new.mpv }

    it 'get player name' do
      expect(player.name).to eq('mpv')
    end

    it 'get player config' do
      expect(player.config).to eq('--no-config --no-audio-display')
    end

    it 'get player media format' do
      expect(player.format).to eq('--ytdl-format="bestvideo[height<=?1080]+bestaudio/best"')
    end
  end
end
