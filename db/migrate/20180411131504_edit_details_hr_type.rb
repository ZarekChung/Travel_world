class EditDetailsHrType < ActiveRecord::Migration[5.1]
  def change
    remove_column :details, :hr
    add_column :details, :hr, :time
  end
end
