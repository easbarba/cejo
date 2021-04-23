# frozen_string_literal: true

require_relative '../../lib/cejo'

require 'spec_helper'

RSpec.describe 'Grabber' do
  let(:grabber) do
    url = 'https://odysee.com/@SystemCrafters:e/installing-the-gnu-guix-package-manager:c'
    Cejo::Media::Grabber.new(url, 'mkv')
  end

  it 'title is not too long' do
    expect(grabber.title).to eq('Installing the GNU Guix Package Manager')
  end

  it 'video command' do
    result = '--extract-audio --audio-format mkv https://odysee.com/@SystemCrafters:e/installing-the-gnu-guix-package-manager:c'
    expect(grabber.audio_command).to eq(result)
  end

  it 'audio command' do
    result = '--extract-audio --audio-format mkv https://odysee.com/@SystemCrafters:e/installing-the-gnu-guix-package-manager:c'
    expect(grabber.audio_command).to eq(result)
  end
  it 'sum up pretty well' do
    expect(grabber.to_s).to eq('Installing the GNU Guix Package Manager.mp4')
  end
end
