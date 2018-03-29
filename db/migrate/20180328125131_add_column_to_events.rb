class AddColumnToEvents < ActiveRecord::Migration[5.1]
  def change
    add_column :events, :disable, :boolean, default: false
  end
end
