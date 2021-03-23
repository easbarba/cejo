# frozen_string_literal: true

require_relative '../../lib/cejo'

require 'spec_helper'

RSpec.describe 'Get' do
  let(:media) { 'https://framatube.org/908ff4b-240.mp4' }
  let(:codec) { 'vorbis' }

  it 'gets me a nice tune to enjoy' do
    base = Cejo::Media::Get.new(media, codec)
    expect(base.final_command).to eq("youtube-dl #{base.audio_command}")
  end

  it 'gets me an amazing video to watch' do
    base = Cejo::Media::Get.new(media)
    expect(base.final_command).to eq("youtube-dl #{base.media}")
  end
end
