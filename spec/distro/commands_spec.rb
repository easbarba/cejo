require_relative "../../lib/cejo/distro/commands"

require "spec_helper"

RSpec.describe "The marvelous distro" do
  context "What about the Commands?" do
    let(:raw_cmd) { { dnf: { autoremove: "autoremove" } }}

    it "has, at least, one packager commands set!" do
      cmd = Cejo::Distro::Commands.new(raw_cmd)

      expect(cmd.packagers.any?).to eq(raw_cmd.any?)
    end

    it "gets all of package, just right!" do
      raw_cmds = raw_cmd.merge({ apt: { autoremove: "autoremove" } })
      cmd = Cejo::Distro::Commands.new(raw_cmds)

      expect(cmd.packagers).to eq(%i[dnf apt])
    end
  end
end
