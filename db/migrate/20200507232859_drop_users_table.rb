class DropUsersTable < ActiveRecord::Migration[5.2]
  def change
    def up
      drop_table :users
    end
  end
end
