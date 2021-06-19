# frozen_string_literal: true

require_relative '../../../lib/cejo'

require 'spec_helper'

module Cejo
  RSpec.describe 'Get' do
    url = 'https://odysee.com/@DistroTube:2/the-best-tiling-window-manager:5'
    current = Cejo::Media::Grabbers.new.youtube_dl
    fake_parser = Class.new do
      attr_accessor :fmt

      def result
        case fmt
        when :ext
          '%(ext)s'
        when :title
          'The Best Tiling Window Manager'
        when :url
          url
        else
          ''
        end
      end
    end.new

    let(:title) { 'The Best Tiling Window Manager' }
    let(:program) { 'youtube-dl' }
    let(:get) do
      info = Cejo::Media::Info.new(url, '', current)
      info.parser = fake_parser
      Cejo::Media::Get.new(info)
    end

    it 'audio current directory' do
      get.info.codec = 'vorbis'
      music_dir = Pathname.new(Dir.home).join('Music')
      expect(get.current_dir).to eq(music_dir)
    end

    it 'video current directory' do
      get.info.codec = 'mkv'
      video_dir = Pathname.new(Dir.home).join('Videos')
      expect(get.current_dir).to eq(video_dir)
    end

    it 'audio final command' do
      get.info.codec = 'vorbis'
      expect(get.final_command).to eq("#{program} -o '#{title}.%(ext)s' --extract-audio --audio-format vorbis #{url}")
    end

    it 'video final command' do
      get.info.codec = 'mkv'
      expect(get.final_command).to eq("#{program} -o '#{title}.%(ext)s' --recode-video mkv #{url}")
    end
  end
end
