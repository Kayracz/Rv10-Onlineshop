class AddSizeIdToProductItems < ActiveRecord::Migration[5.2]
  def change
    add_column :product_items, :size_id, :integer
  end
end
