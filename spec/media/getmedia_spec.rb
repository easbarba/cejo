require_relative "../../lib/cejo"

require "spec_helper"

RSpec.describe "GetMedia" do
  it "gets me a nice tune to enjoy" do
    codec = 'vorbis'
    media = 'https://framatube.org/908ff4b-240.mp4'
    base = Cejo::Media::Getmedia.new(media, codec)

    expect(base.final_command).to eq("youtube-dl #{base.audio_command}")
  end

  it "gets me an amazing video to watch" do
    media = 'https://framatube.org/908ff4b-240.mp4'
    base = Cejo::Media::Getmedia.new(media, nil)

    expect(base.final_command).to eq("youtube-dl #{base.media}")
  end
end
