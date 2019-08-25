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

  def collect_from_garage(garage)
    while !full? && garage.are_there_working_bikes? do
      @bikes << garage.release_bike
    end
  end

  def release_into_station(docking_station)
    while are_there_working_bikes? do
      bike = working_bikes[0]
      docking_station.dock(@bikes.delete(bike))
    end
  end

  def release_into_garage(garage)
    while are_there_broken_bikes? do
      bike = broken_bikes[0]
      garage.dock(@bikes.delete(bike))
    end
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
end
