class CreateEventsOfUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :events_of_users do |t|
      t.references :event, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
