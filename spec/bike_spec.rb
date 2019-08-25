require "bike"

describe Bike do
  it { is_expected.to respond_to :working? }
  it { is_expected.to respond_to :broken }

  it "reports a broken bike" do
    subject.broken
    expect(subject.working?).to be false
  end

end


# it "gets a bike 2 the less readable version" do
#   expect(DockingStation.new.release_bike.working?).to eq true
# end
