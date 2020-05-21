class AddModifiedByToInk < ActiveRecord::Migration[5.2]
  def change
    add_column :inks, :modified_by, :string
  end
end
