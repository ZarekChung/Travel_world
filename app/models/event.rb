class Event < ApplicationRecord
  has_many :events_of_users, dependent: :destroy
  
  has_many :favorites, dependent: :destroy

  has_many :replies, -> {order("created_at DESC")}, dependent: :destroy

  has_many :schedules, -> {order("day ASC")}, dependent: :destroy

  validates_presence_of :country, :title

  amoeba do
    exclude_association :events_of_users
    exclude_association :favorites
    exclude_association :replies
    clone :schedules
    propagate
    set :replies_count => 0
  end

  #def self.all_of_org
  #  顯示全部（複製的除外）
  #  EventsOfUser.where('org_user = user_id')
  #  lists = EventsOfUser.includes(:event).where('org_user = user_id')
  #  org_event = lists.map { |list| list.event }
  #end

  def self.search_events(params)
    return all if params.blank?
    where("title LIKE ? OR country LIKE ? OR district LIKE ?", "%#{params}%", "%#{params}%", "%#{params}%")
  end

  def self.order_search_events(search, order)
    if order.blank?
      search_events(search).order("created_at DESC")
    else
      search_events(search).order("#{order} DESC")
    end
  end
end
