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

  def self.adjust product_id, size_id, units
    stock = Stock.where(product_id: product_id, size_id: size_id).first
    stock&.update_attributes units: units
  end

  def self.by_size product_id, size_id
    stock = Stock.where(product_id: product_id, size_id: size_id).first
    return stock ? stock.units : 0
  end
 
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
    if stock
      # Based on how they handle the cart, they don't want 
      # negative stock, so we check for that here.
      old = stock.units
      return false if old - units < 0
      stock.update_attributes units: old - units
    else
      false
    end
  end
end
