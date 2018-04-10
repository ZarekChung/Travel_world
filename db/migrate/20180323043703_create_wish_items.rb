class CreateWishItems < ActiveRecord::Migration[5.1]
  def change
    create_table :wish_items do |t|
      t.string :place_id
      t.integer :wish_id
      t.float :lat
      t.float :lng
      t.string :spot_name
      t.string :image
      t.string :address
      t.string :district
      t.integer :rating

      t.timestamps
    end
  end
end
