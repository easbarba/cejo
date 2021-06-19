# frozen_string_literal: true

require 'cejo'

require 'spec_helper'

module Cejo
  RSpec.describe 'All hail to the Volume King' do
    utils = Class.new do
      def which?(_)
        :pactl
      end
    end.new

    let(:volume) { Cejo::Ops::Volume.new(utils, 'down') }
    let(:sound) { Cejo::Ops::SoundManager.new(utils) }

    it 'has the final_command' do
      step = Cejo::Ops::Volume::STEP
      sink = sound.info.sink
      expect(volume.final_command).to eq("pactl set-sink-volume #{sink} -#{step}%")
    end
  end
end
