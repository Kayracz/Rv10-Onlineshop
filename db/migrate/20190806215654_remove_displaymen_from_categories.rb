class RemoveDisplaymenFromCategories < ActiveRecord::Migration[5.2]
  def change
    remove_column :categories, :display_in_men, :boolean
  end
end
