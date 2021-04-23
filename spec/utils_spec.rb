# frozen_string_literal: true

require_relative '../lib/cejo'

require 'spec_helper'

RSpec.describe 'Utilities' do
  let(:utils) { Cejo::Services::Utils.new }
  context "What about the Commands?" do
    # it "it does have some command config available!" do
    #   folder = commands.folder
    #   expect(folder.empty?).not_to eq true
    # end

    # it "it has symbols as packagers names!" do
    # packagers = utils.parse_folder
    # expect(packagers[0].class).to eq(Symbol)
    # end
  end
end
