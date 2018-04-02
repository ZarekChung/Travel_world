class ChangeColumnToEvents < ActiveRecord::Migration[5.1]
  def change
    change_column :events, :privacy, :boolean, default: false
  end
end
