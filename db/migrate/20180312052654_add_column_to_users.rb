class AddColumnToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :name, :string, null: false, default: ""
    add_column :users, :gender, :string
    add_column :users, :avatar, :string
    add_column :users, :introduction, :text
    add_column :users, :point, :integer, default: "0"
    add_column :users, :role, :string, default: "normal"

    add_index :users, :name, unique: true
  end
end
