require 'docking_station'

describe DockingStation do
  it { is_expected.to respond_to :release_bike }
  it { is_expected.to respond_to :dock_bike }

  context '#release_bike' do
    it "releases a bike" do
      subject.dock_bike(Bike.new)
      bike = subject.release_bike
      expect(bike.working?).to eq true
    end

    it 'throws an error if there is no bike in the Docking station' do
      expect { subject.release_bike }.to raise_error 'Sorry, no bikes available'
    end
    #   bike = Bike.new
    #   subject.dock_bike(bike)
    #   expect(subject.release_bike).to eq bike
    # end
  end

  context '#dock_bike' do
    it "check that dock_bike saves the bike" do
      bike = Bike.new
      subject.dock_bike(bike)
      expect(subject.bike_store).to include(bike)
    end

    it 'throws an error if there is a bike in the Docking station' do
      subject.dock_bike(Bike.new)
      expect { subject.dock_bike(Bike.new) }.to raise_error 'Sorry, station is full'
    end
  end


end
