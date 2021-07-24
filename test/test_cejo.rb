require 'cejo'

require 'test/unit'

class CejoTest < Test::Unit::TestCase
  def test_english_hello
    assert_equal 'hello world', Cejo.hi('english')
  end

  def test_any_hello
    assert_equal 'hello world', Cejo.hi('ruby')
  end

  def test_spanish_hello
    assert_equal 'cejo mundo', Cejo.hi('spanish')
  end
end
