class Vendor
  attr_reader :name, :inventory

  def initialize(name)
    @name = name
    @inventory = Hash.new(0)
  end

  def check_stock(food)
    @inventory[food]
  end

  def stock(food, quantity)
    @inventory[food] += quantity
  end
end
