class ChangeNullInEvents < ActiveRecord::Migration[5.1]
  def change
    change_column_null :events, :start_at, true
    change_column_null :events, :end_at, true
    change_column_null :events, :country, true

    change_column_null :events, :days, false    
    change_column_null :events, :district, false    
  end
end
