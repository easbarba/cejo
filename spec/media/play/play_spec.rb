# frozen_string_literal: true

require_relative '../../../lib/cejo'

require 'spec_helper'

module Cejo
  RSpec.describe 'Play' do
    let(:media) { '/tmp/Videos/rosa_luxemburgo.ogv' }

    before(:all) do
      filepath = Pathname.new('/tmp/Videos/rosa_luxemburgo.ogv')

      unless filepath.exist?
        filepath.dirname.mkdir
        File.write(filepath, '')
      end
    end

    it 'plays local file' do
      base = Cejo::Media::Play.new media
      expect(base.pick_media).to eq(media)
    end

    it 'plays random file in folder' do
      dirpath = Pathname.new(media).dirname
      base = Cejo::Media::Play.new dirpath.to_path
      expect(base.pick_random_media_in_folder(dirpath)).to eq(media)
    end

    it 'plays online media' do
      url = 'https://framatube.org/908ff4b-240.mp4'
      base = Cejo::Media::Play.new url

      expect(base.pick_media).to eq(url)
    end

    it 'plays final command' do
      url = 'https://framatube.org/908ff4b-240.mp4'
      base = Cejo::Media::Play.new url

      expect(base.final_command).to eq("#{base.player_settings} #{url}")
    end
  end
end
