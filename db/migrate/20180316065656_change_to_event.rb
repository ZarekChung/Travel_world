class ChangeToEvent < ActiveRecord::Migration[5.1]
  def change
    change_column_null :events, :start_at, false
    change_column_null :events, :end_at, false
    change_column_null :events, :country, false
    change_column_null :events, :title, false
  end
end
