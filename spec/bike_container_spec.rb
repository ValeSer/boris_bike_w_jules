require 'bike_container'

shared_examples_for BikeContainer do

  let(:bike) { double(:bike, :working? => true) }
  let(:broken_bike) { double(:bike, :broken => nil, :working? => false, :fix => nil) }

  it { is_expected.to respond_to :release_bike }
  it { is_expected.to respond_to :dock }
  it { is_expected.to respond_to :release_broken_bike }
  it { is_expected.to respond_to :are_there_broken_bikes? }

  context '@capacity' do
    it 'allows a user to set a @capacity' do
      capacity = 2
      station = described_class.new(capacity)
      expect(station.capacity).to eq capacity
    end
    it 'takes DEFAULT_CAPACITY if none is given' do
       expect(subject.capacity).to eq BikeContainer::DEFAULT_CAPACITY
    end
  end

  context '#dock' do
    it 'check that dock saves the bike' do
      subject.dock(bike)
      expect(subject.bikes).to include(bike)
    end

    it 'takes a broken bike' do
      allow(bike).to receive(:broken)
      subject.dock(bike, true)
      expect(subject.bikes).to include(bike)
      expect(bike).to have_received(:broken)
    end

    it 'takes already broken bikes' do
      subject.dock(broken_bike)
      expect(subject.bikes).to include(broken_bike)
    end

    it 'throws an error if there are already 20 bikes in the Docking station' do
      BikeContainer::DEFAULT_CAPACITY.times { subject.dock(double(:bike)) }
      expect { subject.dock(bike) }.to raise_error "Sorry, #{described_class.name} is full"
    end

    it 'throws an error if the limit defined by the user has been reached' do
      capacity = 2
      station = described_class.new(capacity)
      capacity.times { station.dock(double(:bike)) }
      expect { station.dock(double(:bike)) }.to raise_error "Sorry, #{described_class.name} is full"
    end
  end

  context '#release_bike' do
    it 'releases a working bike' do
      subject.dock(bike)
      released_bike = subject.release_bike
      expect(released_bike.working?).to eq true
    end

    it 'releases the bike previously docked' do
      subject.dock(bike)
      released_bike = subject.release_bike
      expect(released_bike).to eq bike
    end

    it 'eliminates the bike released' do
      subject.dock(bike)
      released_bike = subject.release_bike
      expect(subject.bikes.empty?).to eq true
    end

    it 'throws an error if there is no bike in the Bike Container' do
      expect { subject.release_bike }.to raise_error "Sorry, #{described_class.name} is empty"
    end

    it 'does not release broken bikes' do
      subject.dock(broken_bike)
      expect { subject.release_bike }.to raise_error 'Sorry, no bikes available'
    end

    it 'release a working bike' do
      subject.dock(broken_bike)
      subject.dock(bike)
      subject.dock(broken_bike)
      released_bike = subject.release_bike
      expect(released_bike.working?).to eq true
    end
  end

  context '#release_broken_bike' do
    it 'releases a broken bike' do
      subject.dock(broken_bike)
      released_bike = subject.release_broken_bike
      expect(released_bike.working?).to eq false
    end

    it 'throws an error if there is no bike in the Docking station' do
      expect { subject.release_broken_bike }.to raise_error "Sorry, #{described_class.name} is empty"
    end

    it 'does not release working bikes' do
      subject.dock(bike)
      expect { subject.release_broken_bike }.to raise_error 'Sorry, no bikes available'
    end

    it 'release a broken bike' do
      subject.dock(bike)
      subject.dock(broken_bike)
      subject.dock(bike)
      released_bike = subject.release_broken_bike
      expect(released_bike.working?).to eq false
    end
  end

  context '#are_there_working_bikes?' do
    it 'true if there is a working bike' do
      subject.dock(bike)
      expect(subject.are_there_working_bikes?).to eq true
    end

    it 'false if there are no working bikes' do
      subject.dock(broken_bike)
      expect(subject.are_there_working_bikes?).to eq false
    end
  end

  context '#are_there_broken_bikes?' do
    it 'true if there is a broken bike' do
      subject.dock(broken_bike)
      expect(subject.are_there_broken_bikes?).to eq true
    end

    it 'false if there are no broken bikes' do
      subject.dock(bike)
      expect(subject.are_there_broken_bikes?).to eq false
    end
  end
end
