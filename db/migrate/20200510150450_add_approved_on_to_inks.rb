class AddApprovedOnToInks < ActiveRecord::Migration[5.2]
  def change
    add_column :inks, :approved_on, :string
  end
end
