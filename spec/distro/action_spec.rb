require_relative "../../lib/cejo/sections/distro/translate_action"

require "spec_helper"

RSpec.describe "The Glorious Action" do
  let(:action) { Cejo::Distro::TranslateAction.new }

  it "has the real action" do
    commands = {
      apt: { autoremove: "autoremove" },
      dnf: { autoremove: "autoremove" },
    }
    real_action = action.real_action(commands, :dnf, :autoremove)

    expect(real_action).to eq("autoremove")
  end
end
