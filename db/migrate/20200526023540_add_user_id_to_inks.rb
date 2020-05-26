class AddUserIdToInks < ActiveRecord::Migration[5.2]
  def change
    add_column :inks, :user_id, :integer
  end
end
