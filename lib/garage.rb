class Garage
  include BikeContainer

  def fix_bikes
    broken_bikes.map(&:fix)
  end
end
