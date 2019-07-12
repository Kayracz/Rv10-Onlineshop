class AddProductreferencesToPhotos < ActiveRecord::Migration[5.2]
  def change
    add_reference :photos, :product, foreign_key: true
  end
end
