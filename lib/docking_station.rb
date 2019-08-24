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

  def dock_bike(bike)
    raise 'Sorry, station is full' if !@bikes.empty?
    @bikes << bike
  end
end
