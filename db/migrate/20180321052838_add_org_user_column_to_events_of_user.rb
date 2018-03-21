class AddOrgUserColumnToEventsOfUser < ActiveRecord::Migration[5.1]
  def change
    add_column :events_of_users, :org_user, :integer

    rename_column :events_of_users, :creator, :is_create
  end
end
