class Stock < ApplicationRecord

  # The stock table looks something like this
  # +------------+---------+-------+
  # | product_id | size_id | units |
  # +------------+---------+-------+
  # |          1 |       1 |    15 |
  # +------------+---------+-------+
  # |          1 |       2 |    10 |
  # +------------+---------+-------+
  # |          1 |       3 |    40 |
  # +------------+---------+-------+
  # |          2 |       1 |    17 |
  # +------------+---------+-------+
  # And so on....
 
  # Increases the number of units in stock for the
  # given product_id/size_id combination.
  def self.increase product_id, size_id, units
    stock = Stock.where(product_id: product_id, size_id: size_id).first
    if stock
      old = stock.units
      stock.update_attributes units: old + units
    else
      false
    end
  end

  # Decreases the number of units in stock for the
  # given product_id/size_id combination.
  def self.decrease product_id, size_id, units
    stock = Stock.where(product_id: product_id, size_id: size_id).first
    # As of now, we don't check for negative stock. Some companies 
    # like this behavior while others really don't. Adjust accordingly.
    if stock
      old = stock.units
      stock.update_attributes units: old - units
    else
      false
    end
  end
end
