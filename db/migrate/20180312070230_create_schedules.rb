class CreateSchedules < ActiveRecord::Migration[5.1]
  def change
    create_table :schedules do |t|
      t.string :day
      t.string :airplane_name
      t.string :airplane_number
      t.string :airplane_terminal
      t.datetime :airplane_time
      t.string :stay
      t.string :address
      t.datetime :check_in
      t.datetime :check_out
      t.references :event, foreign_key: true, index: true

      t.timestamps
    end
  end
end
