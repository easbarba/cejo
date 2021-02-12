# frozen_string_literal: true

require 'test/unit'

require 'cejo/sections/ops/floss'
require 'cejo/services/configure_services'

# Test Oss
class FlossTest < Test::Unit::TestCase
  def setup
    @services = Cejo::Services::ConfigureServices.new
  end

  def test_get
    floss = Cejo::Ops::Floss.new(@services, 'get')
    floss.ARCHIVE_THESE
  end
end
