class AddNitToOrders < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :Nit, :text
    add_column :orders, :Notas, :text
  end
end
