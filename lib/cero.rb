class Cero
  attr_accessor :venue, :name

  def initialize(name, venue)
    @venue = venue
    @name = name
  end
end

joe = Cero.new("a", "b")
joe.venue = "k"

puts joe.venue
