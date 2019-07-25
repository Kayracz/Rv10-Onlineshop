class ProductItem < ApplicationRecord
  belongs_to :product
  belongs_to :cart
  has_many   :orders

  def total_price
    product.price * quantity
  end

  def size
    Size.find self.size_id
  end

end
