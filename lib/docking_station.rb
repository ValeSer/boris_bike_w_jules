class DockingStation
  attr_reader :bikes, :capacity
  DEFAULT_CAPACITY = 20

  # this method will run every time without calling it
  def initialize(capacity = DEFAULT_CAPACITY)
    @capacity = capacity
    @bikes = []
  end

  def release_bike
    raise 'Sorry, station is empty' if empty?
    available_bikes = working_bikes
    raise 'Sorry, no bikes available' if available_bikes.empty?
    @bikes.delete(available_bikes[0])
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

  def working_bikes
    @bikes.select(&:working?)
  end
end
