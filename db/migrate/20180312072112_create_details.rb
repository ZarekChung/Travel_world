class CreateDetails < ActiveRecord::Migration[5.1]
  def change
    create_table :details do |t|
      t.integer :hr
      t.string :category
      t.text :content
      t.string :traffic
      t.references :schedule, foreign_key: true, index: true
      t.references :spot, foreign_key: true, index: true

      t.timestamps
    end
  end
end
