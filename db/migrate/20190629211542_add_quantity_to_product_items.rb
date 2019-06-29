class AddQuantityToProductItems < ActiveRecord::Migration[5.2]
  def change
    add_column :product_items, :quantity, :integer, default: 1
  end
end
