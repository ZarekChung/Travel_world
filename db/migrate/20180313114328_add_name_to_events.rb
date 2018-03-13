class AddNameToEvents < ActiveRecord::Migration[5.1]
  def change
    add_column :events, :title, :string

    add_index :events, :title, unique: true
  end
end
