require 'test/unit'

require_relative '../../../lib/cero/sections/operations/oss.rb'
require_relative '../../../lib/cero/services/configure_services.rb'

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
