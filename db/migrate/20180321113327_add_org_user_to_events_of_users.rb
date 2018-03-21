class AddOrgUserToEventsOfUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :events_of_users, :org_user, :integer
  end
end
