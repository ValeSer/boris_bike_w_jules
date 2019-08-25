class DockingStation
  attr_reader :bikes, :capacity
  DEFAULT_CAPACITY = 20

  # this method will run every time without calling it
  def initialize(capacity = DEFAULT_CAPACITY)
    @capacity = capacity
    @bikes = []
  end

  def release_bike
    raise 'Sorry, no bikes available' if empty?
    @bikes.pop
  end

  def dock(bike, is_broken = false)
    raise 'Sorry, station is full' if full?
    bike.broken if is_broken
    @bikes << bike
  end

  private

  def full?
    @bikes.count >= @capacity
  end

  def empty?
    @bikes.empty?
  end

end
