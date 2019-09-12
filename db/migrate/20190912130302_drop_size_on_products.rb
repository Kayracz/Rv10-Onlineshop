class DropSizeOnProducts < ActiveRecord::Migration[5.2]
 def up
    remove_column :products, :size
  end

  def down
    add_column :products, :size, :string
  end
end
