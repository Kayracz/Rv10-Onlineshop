class AddTransferToProductItems < ActiveRecord::Migration[5.2]
  def change
    add_reference :product_items, :transfer, foreign_key: true
  end
end
