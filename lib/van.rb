class Van
  attr_reader :bikes
  attr_reader :capacity
  DEFAULT_CAPACITY = 20

  def initialize(capacity = DEFAULT_CAPACITY)
    @bikes = []
    @capacity = capacity
  end

  def collect_from_station(docking_station)
    while !full? && docking_station.are_there_broken_bikes? do
      @bikes << docking_station.release_broken_bike
    end
  end

  private

  def full?
    @bikes.count >= @capacity
  end
end
