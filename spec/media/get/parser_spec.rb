# frozen_string_literal: true

require_relative '../../../lib/cejo'

require 'spec_helper'

module Cejo
  RSpec.describe 'Holy Parser' do
    url = 'https://odysee.com/@SystemCrafters:e/installing-the-gnu-guix-package-manager:c'
    current = Cejo::Media::Grabbers.new.youtube_dl
    let(:parser) { Cejo::Media::Parser.new current, url }

    it 'New format' do
      parser.fmt = :ext
      expect(parser.new_format).to eq("%(ext)s")
    end

    it 'Base two' do
      parser.fmt = :title
      expect(parser.base).to eq("youtube-dl --get-filename -o '%(title)s' #{url}")
    end
  end
end
