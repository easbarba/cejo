# frozen_string_literal: true

require_relative '../../lib/cejo'

require 'spec_helper'

RSpec.describe 'Get' do
  let(:url) { 'https://odysee.com/@DistroTube:2/the-best-tiling-window-manager:5' }
  let(:getaudio) { Cejo::Media::Get.new(url, 'vorbis') }

  it 'gets me an amazing video to watch' do
    main = Cejo::Media::Get.new(url, 'mkv')
    result = '--recode-video mkv https://odysee.com/@DistroTube:2/the-best-tiling-window-manager:5'
    expect(main.grabber.video_command).to eq(result)
  end

  it 'gets me a nice tune to enjoy' do
    expect(getaudio.grabber.audio_command).to eq("--extract-audio --audio-format vorbis #{url}")
  end

  it 'gets correct final command' do
    result = '--extract-audio --audio-format vorbis https://odysee.com/@DistroTube:2/the-best-tiling-window-manager:5'
    expect(getaudio.final_command).to eq(result)
  end
end
