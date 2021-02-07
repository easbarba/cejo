# frozen_string_literal: true

require 'test/unit'

require 'cejo/sections/operations/oss'
require 'cejo/services/configure_services'

# Test Oss
class OssTest < Test::Unit::TestCase
  def setup
    @services = Cejo::Services::ConfigureServices.new
  end

  def test_get
    oss = Cejo::Ops::Oss.new(@services, 'get')
    oss.ARCHIVE_THESE
  end
end
