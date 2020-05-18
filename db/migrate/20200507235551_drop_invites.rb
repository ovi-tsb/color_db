class DropInvites < ActiveRecord::Migration[5.2]
  def up
      drop_table :invites
    end
end
