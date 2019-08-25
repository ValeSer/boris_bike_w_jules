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

  def release_broken_bike
    raise 'Sorry, station is empty' if empty?
    bikes_to_collect = broken_bikes
    raise 'Sorry, no bikes available' if bikes_to_collect.empty?
    @bikes.delete(bikes_to_collect[0])
  end

  # dock "parks" a bike
  def dock(bike, is_broken = false)
    raise 'Sorry, station is full' if full?
    bike.broken if is_broken
    @bikes << bike
  end

  def are_there_broken_bikes?
    broken_bikes.any?
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

  def broken_bikes
    @bikes.reject(&:working?)
  end
end
