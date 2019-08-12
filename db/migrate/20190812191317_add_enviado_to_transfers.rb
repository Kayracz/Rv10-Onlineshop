class AddEnviadoToTransfers < ActiveRecord::Migration[5.2]
  def change
    add_column :transfers, :enviado, :boolean, default: false
  end
end
