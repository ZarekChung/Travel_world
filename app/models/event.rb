class Event < ApplicationRecord
  belongs_to :user, counter_cache: true

  has_many :events_of_users, dependent: :destroy
  
  has_many :favorites, dependent: :destroy

  has_many :likes, dependent: :destroy

  has_many :replies, dependent: :destroy

  has_many :schedules, dependent: :destroy
end
