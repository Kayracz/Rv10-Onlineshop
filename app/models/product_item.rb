class ProductItem < ApplicationRecord
  belongs_to :product
  belongs_to :cart
  has_many   :orders
  has_many :transfers
  has_many :categories

  def total_price
    product.price * quantity
  end

  def size
    Size.find self.size_id
  end

end
