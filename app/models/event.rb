class Event < ApplicationRecord
  validates_presence_of :end_at, :start_at

  has_many :events_of_users, dependent: :destroy
  
  has_many :favorites, dependent: :destroy

  has_many :likes, dependent: :destroy

  has_many :replies, dependent: :destroy

  has_many :schedules, dependent: :destroy, autosave: true
  accepts_nested_attributes_for :schedules, allow_destroy: true, reject_if: :all_blank

end
