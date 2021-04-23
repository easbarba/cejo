# frozen_string_literal: true

require_relative '../../../lib/cejo'

require 'spec_helper'

RSpec.describe 'Grabber' do
  url = 'https://odysee.com/@SystemCrafters:e/installing-the-gnu-guix-package-manager:c'
  current = Cejo::Media::Grabbers.new.youtube_dl
  parser = Class.new do
    def info(_, info, url)
      case info
      when :ext
        'mp4'
      when :title
        'Installing the GNU Guix Package Manager'
      when :url
        url
      else
        ''
      end
    end
  end.new

  let(:grabber) { Cejo::Media::Grabber.new(url, 'vorbis', parser, current) }

  it 'audio command' do
    expect(grabber.audio_command).to eq("--extract-audio --audio-format vorbis #{url}")
  end

  it 'title is not too long' do
    expect(grabber.title).to eq('Installing the GNU Guix Package Manager')
  end

  it 'video command' do
    video_codec = 'mkv'
    grabber.codec = video_codec
    expect(grabber.video_command).to eq("--recode-video #{video_codec} #{url}")
  end

  it 'sum up pretty well' do
    expect(grabber.to_s).to eq('Installing the GNU Guix Package Manager.mp4')
  end
end
