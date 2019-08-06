class RemoveSize2FromProducts < ActiveRecord::Migration[5.2]
  def change
    remove_column :products, :size2, :string
  end
end
