class AddCategoryRefToProductItems < ActiveRecord::Migration[5.2]
  def change
    add_reference :product_items, :category, foreign_key: true
  end
end
