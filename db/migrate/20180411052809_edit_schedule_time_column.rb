class EditScheduleTimeColumn < ActiveRecord::Migration[5.1]
  def change
    change_column :schedules, :airplane_time, :time
    change_column :schedules, :check_in, :time
    change_column :schedules, :check_out, :time
  end
end
