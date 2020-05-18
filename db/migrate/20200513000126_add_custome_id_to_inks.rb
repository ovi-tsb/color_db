class AddCustomeIdToInks < ActiveRecord::Migration[5.2]
  def change
    add_column :inks, :customer_id, :integer, foreign_key: true
  end
end
