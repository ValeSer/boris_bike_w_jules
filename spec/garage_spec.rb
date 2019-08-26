require 'garage'

describe Garage do
  it_behaves_like BikeContainer

  subject(:garage) { Garage.new }
  let(:broken_bike) { double(:bike, :broken => nil, :working? => false, :fix => nil) }
  let(:broken_bike2) { double(:bike, :broken => nil, :working? => false, :fix => nil) }

  it { is_expected.to respond_to :fix_bikes }

  context '#fix_bikes' do
    it 'fixes all broken bikes' do
      garage.dock(broken_bike)
      garage.dock(broken_bike2)
      garage.fix_bikes
      expect(broken_bike).to have_received(:fix)
      expect(broken_bike2).to have_received(:fix)
    end
  end
end
