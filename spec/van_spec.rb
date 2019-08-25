require 'van'

describe Van do
  subject(:van) { Van.new }
  let(:docking_station) { double(:docking_station) }
  let(:garage) { double(:garage, :dock => nil) }
  let(:bike) { double(:bike, :working? => true) }
  let(:broken_bike) { double(:bike, :broken => nil, :working? => false) }

  it { is_expected.to respond_to :collect_from_station }
  it { is_expected.to respond_to :release_into_garage }

  context '#collect_from_station' do
    it 'collects a broken bike' do
      allow(docking_station).to receive(:release_broken_bike).and_return(broken_bike)
      allow(docking_station).to receive(:are_there_broken_bikes?).and_return(true, false)
      van.collect_from_station(docking_station)
      expect(van.bikes).to include(broken_bike)
    end

    it 'collects multiple broken bikes' do
      allow(docking_station).to receive(:release_broken_bike).and_return(broken_bike)
      allow(docking_station).to receive(:are_there_broken_bikes?).and_return(true, true, false)
      van.collect_from_station(docking_station)
      expect(van.bikes.count).to eq 2
    end

    it 'collects nothing if there are no broken bikes' do
      allow(docking_station).to receive(:are_there_broken_bikes?).and_return(false)
      van.collect_from_station(docking_station)
      expect(van.bikes.empty?).to eq true
    end

    it 'collects until full' do
      allow(docking_station).to receive(:release_broken_bike).and_return(broken_bike)
      allow(docking_station).to receive(:are_there_broken_bikes?).and_return(true)
      van.collect_from_station(docking_station)
      expect(van.bikes.count).to eq van.capacity
    end
  end

  context '@capacity' do
    it 'allows a user to set a @capacity instance variable when Van.new is called' do
      capacity = 2
      van = Van.new(capacity)
      expect(van.capacity).to eq capacity
    end
    it 'takes DEFAULT_CAPACITY if none is given' do
       expect(van.capacity).to eq Van::DEFAULT_CAPACITY
    end
  end

  context '#release_into_garage' do
    it 'unloads all bikes' do
      van.bikes << broken_bike
      van.bikes << broken_bike
      van.release_into_garage(garage)
      expect(van.bikes.empty?).to be true
    end

    it 'unloads only broken bikes' do
      van.bikes << broken_bike
      van.bikes << bike
      van.release_into_garage(garage)
      expect(van.bikes).to include bike
    end
  end

end
