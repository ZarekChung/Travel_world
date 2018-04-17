class EventsOfUser < ApplicationRecord
  belongs_to :event
  belongs_to :user
  validates :user_id, uniqueness: { scope: [:event_id, :org_event] }
  validates :org_user, uniqueness: { scope: :event_id }, allow_nil: true


  def self.find_org_user(event)
    where(event: event).first.org_user
  end

end
