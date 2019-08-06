class RemoveDisplaynavFromCategories < ActiveRecord::Migration[5.2]
  def change
    remove_column :categories, :display_in_navbar, :boolean
  end
end
