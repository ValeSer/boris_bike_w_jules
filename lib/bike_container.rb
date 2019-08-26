module BikeContainer
  DEFAULT_CAPACITY = 20

  attr_reader :capacity, :bikes

  # this method will run every time without calling it
  def initialize(capacity = DEFAULT_CAPACITY)
    @capacity = capacity
    @bikes = []
  end

  # dock "parks" a bike
  def dock(bike, is_broken = false)
    raise "Sorry, #{self.class.name} is full" if full?
    bike.broken if is_broken
    @bikes << bike
  end

  def release_bike
    get_bike(working_bikes)
  end

  def release_broken_bike
    get_bike(broken_bikes)
  end

  def are_there_broken_bikes?
    broken_bikes.any?
  end

  def are_there_working_bikes?
    working_bikes.any?
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

  def get_bike(bikes)
    raise "Sorry, #{self.class.name} is empty" if empty?
    raise 'Sorry, no bikes available' if bikes.empty?
    @bikes.delete(bikes[0])
  end
end
