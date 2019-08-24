class DockingStation
  attr_reader :bike_store

  # this method will run every time without calling it
  def initialize
    @bike_store = []
  end

  def release_bike
    raise 'Sorry, no bikes available' if @bike_store.empty?
    Bike.new
  end

  def dock_bike(bike)
    raise 'Sorry, station is full' if !@bike_store.empty?
    @bike_store << bike
  end
end
