class CreateInks < ActiveRecord::Migration[5.2]
  def change
    create_table :inks do |t|
      t.string :name
      t.string :client
      t.string :ink_type
      t.string :substrate
      t.string :coating
      t.string :ink_number
      t.string :sap
      t.boolean :approved

      t.timestamps
    end
  end
end
