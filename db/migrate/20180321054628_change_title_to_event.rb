class ChangeTitleToEvent < ActiveRecord::Migration[5.1]
  def change
    remove_index :events, :title

    add_index :events, :title
  end
end
