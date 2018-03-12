class CreateEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :events do |t|
      t.date :start_at
      t.date :end_at
      t.string :country
      t.integer :days
      t.string :district
      t.text :info
      t.integer :arg_nums
      t.boolean :privacy
      t.boolean :report, default: "false"

      t.timestamps
    end
  end
end
