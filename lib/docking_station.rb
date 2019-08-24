class DockingStation
  attr_reader :bike_store

  # this method will run every time without calling it
  def initialize
      @bike_store = []
  end

  def release_bike
    # fail @bike_store.empty?
    fail "No bikes available" unless @bike
    @bike
  end

  def dock(bike)
    @bike_store << bike
  end
end

class Bike
    def working?
      true
    end
end
