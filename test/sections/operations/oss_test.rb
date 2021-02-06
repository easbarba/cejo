# frozen_string_literal: true

require 'test/unit'

require 'cero/sections/operations/oss'
require 'cero/services/configure_services'

# Test Oss
class OssTest < Test::Unit::TestCase
  def setup
    @services = Cero::Services::ConfigureServices.new
  end

  def test_get
    oss = Cero::Ops::Oss.new(@services, 'get')
    oss.ARCHIVE_THESE
  end
end
