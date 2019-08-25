require 'docking_station'

describe DockingStation do
  it { is_expected.to respond_to :release_bike }
  it { is_expected.to respond_to :dock }

  context '#release_bike' do
    it "releases a bike" do
      subject.dock(Bike.new)
      bike = subject.release_bike
      expect(bike.working?).to eq true
    end

    it 'throws an error if there is no bike in the Docking station' do
      expect { subject.release_bike }.to raise_error 'Sorry, no bikes available'
    end
  end

  context '#dock' do
    it "check that dock saves the bike" do
      bike = Bike.new
      subject.dock(bike)
      expect(subject.bikes).to include(bike)
    end

    it "takes a broken bike" do
      bike = Bike.new
      subject.dock(bike, true)
      expect(subject.bikes).to include(bike)
      expect(bike.working?).to be false
    end

    it 'throws an error if there are already 20 bikes in the Docking station' do
      DockingStation::DEFAULT_CAPACITY.times { subject.dock(Bike.new) }
      expect { subject.dock(Bike.new) }.to raise_error 'Sorry, station is full'
    end

    it 'throws an error if the limit defined by the user has been reached' do
      capacity = 2
      station = DockingStation.new(capacity)
      capacity.times { station.dock(Bike.new) }
      expect { station.dock(Bike.new) }.to raise_error 'Sorry, station is full'
    end

  end

  context 'docking and releasing from storage' do
    it 'releases the bike previously docked' do
      bike = Bike.new
      subject.dock(bike)
      released_bike = subject.release_bike
      expect(released_bike).to eq bike
    end

    it 'eliminates the bike released' do
      bike = Bike.new
      subject.dock(bike)
      released_bike = subject.release_bike
      expect(subject.bikes.empty?).to eq true
    end
  end

  context '@capacity' do
    it 'allows a user to set a @capacity instance variable when DockingStation.new is called' do
      capacity = 2
      station = DockingStation.new(capacity)
      expect(station.capacity).to eq capacity
    end
    it 'takes DEFAULT_CAPACITY if none is given' do
       expect(subject.capacity).to eq DockingStation::DEFAULT_CAPACITY
    end
  end
end
