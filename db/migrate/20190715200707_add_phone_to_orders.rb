class AddPhoneToOrders < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :phone, :integer
  end
end
