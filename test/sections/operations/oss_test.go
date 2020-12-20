require 'test/unit'
require 'sections/operations/oss.rb'
require 'services/git.rb'

class OssTest < Test::Unit::TestCase
  def setup
    git = Cero::Services::Git.new
    @oss = Cero::Operations::Oss.new(git)
  end

  def test_Get
    @oss.run()
  end
