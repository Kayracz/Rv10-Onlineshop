class AddSize2ToProducts < ActiveRecord::Migration[5.2]
  def change
    add_column :products, :size2, :string
  end
end
