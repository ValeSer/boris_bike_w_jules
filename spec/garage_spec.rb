require 'garage'

describe Garage do
  subject(:garage) { Garage.new }
  let(:bike) { double(:bike, :working? => true) }
  let(:broken_bike) { double(:bike, :broken => nil, :working? => false, :fix => nil) }

  it { is_expected.to respond_to :release_bike }
  it { is_expected.to respond_to :dock }
  it { is_expected.to respond_to :fix_bikes }
  it { is_expected.to respond_to :are_there_working_bikes? }

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

  context '#fix_bikes' do
    it 'fixes all broken bikes' do
      broken_bike2 = double(:bike, :broken => nil, :working? => false, :fix => nil);
      garage.dock(broken_bike)
      garage.dock(broken_bike2)
      garage.fix_bikes
      expect(broken_bike).to have_received(:fix)
      expect(broken_bike2).to have_received(:fix)
    end
  end

end
