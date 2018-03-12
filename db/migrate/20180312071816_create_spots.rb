class CreateSpots < ActiveRecord::Migration[5.1]
  def change
    create_table :spots do |t|
      t.string :spot_name
      t.string :image

      t.timestamps
    end

    add_index :spots, :spot_name, unique: true
  end
end
