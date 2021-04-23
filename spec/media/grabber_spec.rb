# frozen_string_literal: true

require_relative '../../lib/cejo'

require 'spec_helper'

RSpec.describe 'Grabber' do
  url = 'https://odysee.com/@SystemCrafters:e/installing-the-gnu-guix-package-manager:c'
  let(:grabber) do
    Cejo::Media::Grabber.new(url, 'mkv')
  end

  it 'audio command' do
    grabber = Cejo::Media::Grabber.new(url, 'vorbis')
    expect(grabber.audio_command).to eq("--extract-audio --audio-format vorbis #{url}")
  end

  it 'title is not too long' do
    expect(grabber.title).to eq('Installing the GNU Guix Package Manager')
  end

  it 'video command' do
    expect(grabber.video_command).to eq("--recode-video mkv #{url}")
  end

  it 'sum up pretty well' do
    expect(grabber.to_s).to eq('Installing the GNU Guix Package Manager.mp4')
  end
end
