class EventsOfUser < ApplicationRecord
  belongs_to :event
  belongs_to :user #, counter_cache: true
  validates :user_id, uniqueness: { scope: :event_id }
  #validates :org_user, uniqueness: { scope: :user_id }


  def self.copy(event)
    where(event: event).first.dup
  end

  def self.cloned_event(user)
    includes(:event).where("user_id = ? and org_user != ?", user, user.id)
  end

  def self.find_myevent(user)
    includes(:event).where(org_user: user.id)
  end

  def self.find_org_user(event)
    where(event: event).first.org_user
  end

end
