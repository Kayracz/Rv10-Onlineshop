class AddPromoToProducts < ActiveRecord::Migration[5.2]
  def change
    add_column :products, :promo, :string
  end
end
