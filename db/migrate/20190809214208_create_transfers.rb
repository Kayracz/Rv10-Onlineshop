class CreateTransfers < ActiveRecord::Migration[5.2]
  def change
    create_table :transfers do |t|
      t.string :name
      t.string :email
      t.text :address
      t.string :city
      t.string :Nit
      t.string :Notas
      t.string :phone

      t.timestamps
    end
  end
end
