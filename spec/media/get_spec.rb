# frozen_string_literal: true

require_relative '../../lib/cejo'

require 'spec_helper'

RSpec.describe 'Get' do
  let(:media) { 'https://framatube.org/908ff4b-240.mp4' }
  let(:codec) { 'vorbis' }

  it 'gets me an amazing video to watch' do
    main = Cejo::Media::Get.new(media)
    expect(media).to eq(main.video_command)
  end

  it 'gets me a nice tune to enjoy' do
    main = Cejo::Media::Get.new(media, codec)
    expect("--extract-audio --audio-format #{codec} #{media}").to eq(main.audio_command)
  end
end
