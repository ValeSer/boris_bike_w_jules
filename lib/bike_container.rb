module BikeContainer
  DEFAULT_CAPACITY = 20

  attr_reader :capacity

  # this method will run every time without calling it
  def initialize(capacity = DEFAULT_CAPACITY)
    @capacity = capacity
    @bikes = []
  end
end
