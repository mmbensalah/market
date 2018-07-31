require 'pry'
class Market
  attr_reader :name, :vendors
  def initialize(name)
    @name = name
    @vendors = []
  end

  def add_vendor(vendor)
    @vendors << vendor
  end

  def vendor_names
    @vendors.map do |vendor|
      vendor.name
    end
  end

  def vendors_that_sell(food)
    all_inventory = @vendors.find_all do |vendor|
      vendor.inventory
    end
    all_inventory.find_all do |vendor|
      vendor.check_stock(food) > 0
    end
  end

  def sorted_item_list
    @vendors.map do |vendor|
      vendor.inventory.keys
    end.flatten.uniq.sort
  end

  def total_inventory
    all_inv_array = inventory_items_to_array
    all_inv_array.inject(Hash.new(0)) do |total_inventory, food|
       total_inventory[food[0]] += food[1]
       total_inventory
     end
  end

  def inventory_items_to_array
    all_inventory = @vendors.map do |vendor|
      vendor.inventory
    end

    all_inventory.map do |food|
      food.to_a
    end.flatten(1)
  end

  def sell(food, quantity)
    if total_inventory[food] >= quantity
      @vendors.map do |vendor|
       if (vendor.inventory[food] -= quantity) < 0
         vendor.inventory[food] = 0
        end
      end
    end
  end
end
