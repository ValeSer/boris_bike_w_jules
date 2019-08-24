class DockingStation
  attr_reader :bikes

  # this method will run every time without calling it
  def initialize
    @bikes = []
  end

  def release_bike
    raise 'Sorry, no bikes available' if @bikes.empty?
    @bikes.pop
  end

  def dock(bike)
    raise 'Sorry, station is full' if @bikes.count >= 20
    @bikes << bike
  end
end
