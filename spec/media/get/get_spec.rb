# frozen_string_literal: true

require_relative '../../../lib/cejo'

require 'spec_helper'

RSpec.describe 'Get' do
  url = 'https://odysee.com/@DistroTube:2/the-best-tiling-window-manager:5'
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
  current = Cejo::Media::Grabbers.new.youtube_dl
  grabber = Cejo::Media::Grabber.new(url, '', parser, current)

  let(:get) { Cejo::Media::Get.new(grabber) }

  it 'audio current directory' do
    get.grabber.codec = 'vorbis'
    expect(get.current_dir).to eq(Pathname.new(Dir.home).join('Music'))
  end

  it 'video current directory' do
    get.grabber.codec = 'mkv'
    expect(get.current_dir).to eq(Pathname.new(Dir.home).join('Videos'))
  end

  it 'audio final command' do
    get.grabber.codec = 'vorbis'
    expect(get.final_command).to eq("--extract-audio --audio-format vorbis #{url}")
  end

  it 'video final command' do
    get.grabber.codec = 'mkv'
    expect(get.final_command).to eq("--recode-video mkv #{url}")
  end
end
