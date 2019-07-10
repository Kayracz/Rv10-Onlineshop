class AddSizeToProducts < ActiveRecord::Migration[5.2]
  def change
    add_column :products, :size, :string
  end
end
