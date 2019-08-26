class Van
  include BikeContainer

  def collect_from_station(docking_station)
    while !full? && docking_station.are_there_broken_bikes? do
      dock(docking_station.release_broken_bike)
    end
  end

  def collect_from_garage(garage)
    while !full? && garage.are_there_working_bikes? do
      dock(garage.release_bike)
    end
  end

  def release_into_station(docking_station)
    while are_there_working_bikes? do
      docking_station.dock(release_bike)
    end
  end

  def release_into_garage(garage)
    while are_there_broken_bikes? do
      garage.dock(release_broken_bike)
    end
  end
end
