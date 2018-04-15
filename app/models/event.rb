class Event < ApplicationRecord
  #belongs_to :user, counter_cache: true
  validates_presence_of :title, :days, :district

  has_many :events_of_users, dependent: :destroy
  has_many :users, through: :events_of_users

  has_many :favorites, dependent: :destroy
  has_many :favorited_users, through: :favorites, source: :user
  has_many :replies, -> {order("created_at DESC")}, dependent: :destroy

  has_many :schedules, -> {order("day ASC")}, dependent: :destroy

  # amoeba gem for deep clone feature
  amoeba do
    exclude_association :events_of_users
    exclude_association :favorites
    exclude_association :replies
    clone :schedules
    propagate
    set :replies_count => 0
  end

  def self.all_of_org_events
    #display all of events except cloned
    includes(:events_of_users, schedules: :details).where.not(disable: true, details: { spot_id: nil}, events_of_users: { event_id: nil }).where(events_of_users: { org_user: nil})
  end

  def self.search_events(params)
    # method for search events feature
    return all_of_org_events if params.blank?
    all_of_org_events.where("title LIKE ? OR country LIKE ? OR district LIKE ?", "%#{params}%", "%#{params}%", "%#{params}%")
  end

  def self.order_search_events(search, order)
    # method for search events feature and sort events
    if order.blank?
      search_events(search).order("events.created_at DESC")
    else
      search_events(search).order("events.#{order} DESC")
    end
  end

  def country_name
    I18n.t(self.country, :scope => :countries) #中文
    #ISO3166::Country[self.country].name ＃英文
  end

end
