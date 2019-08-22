require 'docking_station'

describe DockingStation do
  it " expects release_bike to be a method of docking_station" do
    is_expected.to respond_to(:release_bike)
  end
end
