class AddColumnToSpots < ActiveRecord::Migration[5.1]
  def change
    add_column :spots, :place_id, :string
    add_column :spots, :address, :string
    add_column :spots, :rating, :integer
    add_column :spots, :lat, :float
    add_column :spots, :lng, :float
  end
end
