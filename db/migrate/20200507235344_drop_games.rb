class DropGames < ActiveRecord::Migration[5.2]
  def up
    drop_table :groups
  end
end
