class AddTerminostransferToTransfers < ActiveRecord::Migration[5.2]
  def change
    add_column :transfers, :terminos, :boolean, default: false
  end
end
