class Event < ApplicationRecord
  has_many :events_of_users, dependent: :destroy
  
  has_many :favorites, dependent: :destroy

  has_many :likes, dependent: :destroy

  has_many :replies, -> {order("created_at DESC")}, dependent: :destroy

  has_many :schedules, -> {order("day ASC")}, dependent: :destroy


  def self.search(search)
    if search
      where("title Like ? or country Like? or district Like?", "%#{search}%", "%#{search}%", "%#{search}%").order("created_at DESC")
    else
      all.order("created_at DESC")
    end
  end
end
