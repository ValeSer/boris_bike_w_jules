require 'garage'

describe Garage do
  subject(:garage) { Garage.new }
  let(:bike) { double(:bike, :working? => true) }
  let(:broken_bike) { double(:bike, :broken => nil, :working? => false) }

  it { is_expected.to respond_to :release_bike }
  it { is_expected.to respond_to :dock }

  context '#dock' do

    it 'takes already broken bikes' do
      garage.dock(broken_bike)
      expect(garage.bikes).to include(broken_bike)
    end

    it 'throws an error if the garage is full' do
      Garage::DEFAULT_CAPACITY.times { garage.dock(double(:bike)) }
      expect { garage.dock(broken_bike) }.to raise_error 'Sorry, garage is full'
    end

    it 'throws an error if the limit defined by the user has been reached' do
      capacity = 2
      garage = Garage.new(capacity)
      capacity.times { garage.dock(double(:bike)) }
      expect { garage.dock(broken_bike) }.to raise_error 'Sorry, garage is full'
    end
  end

  context '#release_bike' do
    it 'releases a bike' do
      garage.dock(bike)
      released_bike = garage.release_bike
      expect(released_bike.working?).to eq true
    end

    it 'throws an error if there is no bike in the Garage' do
      expect { garage.release_bike }.to raise_error 'Sorry, garage is empty'
    end

    it 'does not release broken bikes' do
      garage.dock(broken_bike)
      expect { garage.release_bike }.to raise_error 'Sorry, no bikes available'
    end

    it 'release a working bike' do
      garage.dock(broken_bike)
      garage.dock(bike)
      garage.dock(broken_bike)
      released_bike = garage.release_bike
      expect(released_bike.working?).to eq true
    end
  end

end
