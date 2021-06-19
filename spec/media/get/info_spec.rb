# frozen_string_literal: true

require_relative '../../../lib/cejo'

require 'spec_helper'

module Cejo
  RSpec.describe 'Info' do
    url = 'https://odysee.com/@SystemCrafters:e/installing-the-gnu-guix-package-manager:c'
    current = Cejo::Media::Grabbers.new.youtube_dl
    fake_parser = Class.new do
      attr_accessor :fmt

      def result
        case fmt
        when :ext
          '%(ext)s'
        when :title
          'Installing the GNU Guix Package Manager - Craft Your System with GNU Guix #2'
        when :url
          url
        else
          ''
        end
      end
    end.new
    let(:title) { 'Installing the GNU Guix Package Manager' }
    let(:program) { 'youtube-dl' }
    let(:info) do
      r = Cejo::Media::Info.new(url, 'vorbis', current)
      r.parser = fake_parser
      r
    end

    it 'audio command' do
      expect(info.audio_command).to eq("#{program} -o '#{title}.%(ext)s' --extract-audio --audio-format vorbis #{url}")
    end

    it 'title is not too long' do
      expect(info.title).to eq(title)
    end

    it 'video command' do
      video_codec = 'mkv'
      info.codec = video_codec
      expect(info.video_command).to eq("#{program} -o '#{title}.%(ext)s' --recode-video #{video_codec} #{url}")
    end

    it 'sum up pretty well' do
      expect(info.to_s).to eq("#{title}.%(ext)s")
    end
  end
end
