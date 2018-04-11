class AddColumnToDetails < ActiveRecord::Migration[5.1]
  def change
    add_column :details, :strat_t, :datetime
    add_column :details, :name, :string

    remove_column :details, :category
    #change_column :details, :category, 'integer USING CAST(category AS integer)'
    add_column :details, :category_id, :integer
  end
end
