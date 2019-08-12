class AddRecibidoToTransfers < ActiveRecord::Migration[5.2]
  def change
    add_column :transfers, :recibido, :boolean, default: false
  end
end
