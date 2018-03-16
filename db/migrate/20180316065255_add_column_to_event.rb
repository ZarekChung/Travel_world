class AddColumnToEvent < ActiveRecord::Migration[5.1]
  def change
    add_column :events, :last_update_user, :integer
    add_column :events, :photo, :string
  end
end
