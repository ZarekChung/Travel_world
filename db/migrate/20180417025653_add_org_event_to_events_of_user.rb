class AddOrgEventToEventsOfUser < ActiveRecord::Migration[5.1]
  def change
    add_column :events_of_users, :org_event, :integer
  end
end
