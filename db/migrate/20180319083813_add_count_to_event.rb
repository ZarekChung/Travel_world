class AddCountToEvent < ActiveRecord::Migration[5.1]
  def change
    add_column :events, :likes_count, :integer, default: 0
    add_column :events, :replies_count, :integer, default: 0
    add_column :events, :favorites_count, :integer, default: 0

    Event.pluck(:id).each do |i|
      Event.reset_counters(i, :likes)
      Event.reset_counters(i, :replies)
      Event.reset_counters(i, :favorites)
    end
  end
end
