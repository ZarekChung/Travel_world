class Event < ApplicationRecord
  has_many :events_of_users, dependent: :destroy
  
  has_many :favorites, dependent: :destroy

  has_many :replies, -> {order("created_at DESC")}, dependent: :destroy

  has_many :schedules, -> {order("day ASC")}, dependent: :destroy

  validates_presence_of :country, :title
  
  searchable do
    text :country, :boost => 2
    text :district

    time :created_at
  end

end
