class AddCommentsToInks < ActiveRecord::Migration[5.2]
  def change
    add_column :inks, :comments, :string
  end
end
