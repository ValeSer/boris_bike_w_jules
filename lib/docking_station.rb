class DockingStation
  attr_reader :bike_store

  # this method will run every time without calling it
  def initialize
    @bike_store = []
  end

  def release_bike
    if @bike_store.empty?
      raise 'Sorry, no bikes available'
    end
    Bike.new
  end

  def dock_bike(bike)
    @bike_store << bike
  end
end
