require 'bike_container'

shared_examples_for BikeContainer do

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
end
