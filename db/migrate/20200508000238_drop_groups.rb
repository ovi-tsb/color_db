class DropGroups < ActiveRecord::Migration[5.2]
  def up
    drop_table :games
  end
end
