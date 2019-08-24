require "bike"

describe Bike do
  it { is_expected.to respond_to :working? }
end

# it "gets a bike 2 the less readable version" do
#   expect(DockingStation.new.release_bike.working?).to eq true
# end
