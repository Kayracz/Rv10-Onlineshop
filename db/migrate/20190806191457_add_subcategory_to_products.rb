class AddSubcategoryToProducts < ActiveRecord::Migration[5.2]
  def change
    add_column :products, :subcategory, :string
  end
end
