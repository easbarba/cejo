require_relative "../../lib/cejo"

require "spec_helper"

RSpec.describe "Base one...two" do
  let(:folders) {
    Class.new do
      def cejo_config
        Pathname.new '/home/engels/.config/cejo'
      end
    end.new
  }

  let(:utils) {
    Class.new do
      def which?(x)
        true
      end

      def parse_folder(x)
        { apt: { install: 'install' } }
      end
    end.new
  }

  it "has action argument as symbol" do
    base = Cejo::Distro::Base.new(folders, utils, nil, :search)
    expect(base.action).to eq(:search)
  end

  it "has string arguments" do
    base = Cejo::Distro::Base.new(folders, utils, 'fonts-hack' ,:install)
    expect(base.arguments).to eq('fonts-hack')
  end

  it "has does not have arguments" do
    base = Cejo::Distro::Base.new(folders, utils, nil, :update)
    expect(base.arguments).to eq(nil)
  end

  it "has the translated action" do
    base = Cejo::Distro::Base.new(folders, utils, 'fonts-hack', :install)
    expect(base.trans_action).to eq('install')
  end

  it "has the final_command" do
    base = Cejo::Distro::Base.new(folders, utils, 'fonts-hack', :install)
    expect(base.final_command).to eq('sudo apt install fonts-hack')
  end

  it "has the commands" do
    base = Cejo::Distro::Base.new(folders, utils, 'fonts-hack', :install)
    expect(base.commands).to eq(base.utils.parse_folder(''))
  end

  it "has the pakager" do
    base = Cejo::Distro::Base.new(folders, utils, 'fonts-hack', :install)
    expect(base.packager).to eq(:apt)
  end
end
