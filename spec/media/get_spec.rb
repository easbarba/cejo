require_relative "../../lib/cejo"

require "spec_helper"

RSpec.describe "Get" do
  let(:args) { ['https://framatube.org/908ff4b-240.mp4', 'vorbis'] }

  it "gets me a nice tune to enjoy" do

    base = Cejo::Media::Get.new(args)

    expect(base.final_command).to eq("youtube-dl #{base.audio_command}")
  end

  it "gets me an amazing video to watch" do
    base = Cejo::Media::Get.new(args[0])

    expect(base.final_command).to eq("youtube-dl #{base.media}")
  end
end
