class AddMenbooleanToCategories < ActiveRecord::Migration[5.2]
  def change
    add_column :categories, :display_in_men, :boolean
  end
end
