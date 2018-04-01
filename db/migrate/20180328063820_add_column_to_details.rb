class AddColumnToDetails < ActiveRecord::Migration[5.1]
  def change
    add_column :details, :strat_t, :datetime
    add_column :details, :name, :string

    #change_column :details, :category, :integer
    change_column :details, :category, 'integer USING CAST(column_name AS integer)'
    rename_column :details, :category, :category_id
  end
end
