class RemoveIndexToUser < ActiveRecord::Migration[5.1]
  def change
    remove_index :users, :name
  end
end
