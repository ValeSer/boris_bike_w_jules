class DockingStation
    @bike_store = []

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
