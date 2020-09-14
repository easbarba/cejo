# frozen_string_literal: true

# Return Operations Modules
class OperationsClient
  attr_reader :git

  def initialize(git)
    @git = git
  end

  def oss
    oss = Oss.new(@git)
  end
end
