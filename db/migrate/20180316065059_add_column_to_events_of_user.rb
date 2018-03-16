class AddColumnToEventsOfUser < ActiveRecord::Migration[5.1]
  def change
    add_column :events_of_users, :creator, :boolean, default: true
  end
end
