class DockingStation
  attr_reader :bikes
  DEFAULT_CAPACITY = 20

  # this method will run every time without calling it
  def initialize
    @bikes = []
  end

  def release_bike
    raise 'Sorry, no bikes available' if empty?
    @bikes.pop
  end

  def dock(bike)
    raise 'Sorry, station is full' if full?
    @bikes << bike
  end

  private

  def full?
    @bikes.count >= DEFAULT_CAPACITY
  end

  def empty?
    @bikes.empty?
  end

end
