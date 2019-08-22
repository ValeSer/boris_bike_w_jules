require "docking_station"

describe Bike do
  it "Does the bike class respond to the method working?" do
    is_expected.to respond_to(:working?)
  end
end
