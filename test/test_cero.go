require 'test/unit'
require 'cero'

class CeroTest < Test::Unit::TestCase
  def test_english_hello
    assert_equal "hello world", Cero.hi("english")
  end

  def test_any_hello
    assert_equal "hello world", Cero.hi("ruby")
  end

  def test_spanish_hello
    assert_equal "cero mundo", Cero.hi("spanish")
  end
end
