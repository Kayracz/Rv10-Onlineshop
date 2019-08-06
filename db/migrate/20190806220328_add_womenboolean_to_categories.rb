class AddWomenbooleanToCategories < ActiveRecord::Migration[5.2]
  def change
    add_column :categories, :display_in_women, :boolean
  end
end
