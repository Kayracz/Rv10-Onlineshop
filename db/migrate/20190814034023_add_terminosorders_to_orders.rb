class AddTerminosordersToOrders < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :terminos, :boolean, default: false
  end
end
