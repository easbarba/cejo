require_relative "../../lib/cejo/distro/current_packager"

require "spec_helper"

RSpec.describe "The marvelous distro" do
  context "What about the Commands?" do
    let(:raw_cmd) { { dnf: { autoremove: "autoremove" } }}

    it "has, at least, one packager commands set!" do
      cmd = Cejo::Distro::Commands.new(raw_cmd)

      expect(cmd.packagers.any?).to eq(raw_cmd.any?)
    end
  end
end
