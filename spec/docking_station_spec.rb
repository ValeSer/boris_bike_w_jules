require 'docking_station'

describe DockingStation do
  it "expects release_bike to be a method of docking_station" do
    is_expected.to respond_to(:release_bike)
  end

  it "gets a bike" do
    station = DockingStation.new
    bike = station.release_bike
    expect(bike.working?).to eq true
  end

  it "gets a bike 2 the less readable version" do
    expect(DockingStation.new.release_bike.working?).to eq true
  end

end
