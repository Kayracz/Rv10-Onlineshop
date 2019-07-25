class Cart < ApplicationRecord
  has_many :product_items, dependent: :destroy

  def add_product(product_id, size_id)
    # The way to uniquely identify the product is by
    # its id *and* its size.
    # This allows users to add the same product in
    # different sizes to the cart.
    current_item = product_items.where(
      product_id: product_id,
      size_id: size_id).first

    if current_item
      current_item.quantity += 1
    else
      current_item = product_items.build(product_id: product_id)
    end

    current_item.size_id = size_id
    current_item
  end

  def total_price
    product_items.to_a.sum{|item| item.total_price}
  end

end
