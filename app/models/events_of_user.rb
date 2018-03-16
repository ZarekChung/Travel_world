class EventsOfUser < ApplicationRecord
  belongs_to :event
  belongs_to :user
  validates :user, uniqueness: { scope: :event }

  def self.copy(event)
    where(event: event).first.dup
  end
end
