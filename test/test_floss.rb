# frozen_string_literal: true

require 'test/unit'

require 'cejo'

# Test Oss
class FlossTest < Test::Unit::TestCase
  def test_get
    floss = Core.new(@services, 'get')
    floss.ARCHIVE_THESE
  end
end
