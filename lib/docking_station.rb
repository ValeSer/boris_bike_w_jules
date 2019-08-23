class DockingStation
  # this method will run every time without calling it
  def initialize
      @bike_store = []
  end

  def release_bike
    bike = Bike.new
  end

  def dock_bike(bike)
    @bike_store << bike
  end
end

class Bike
    def working?
      true
    end
end
