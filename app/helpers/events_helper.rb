module EventsHelper

  def favorited?(event, user)
    event.favorites.where(user: user).exists?
  end

  def clone?(event, user)
    org_user = EventsOfUser.find_by(event: event).org_user
    EventsOfUser.cloned_event(user).where(org_user: org_user).exists?
  end

  def myEvent?(event, user)
    EventsOfUser.where(org_user: user, event: event).exists?
  end

  def org_user_name(event)
    org_user = EventsOfUser.find_by(event: event).org_user
    User.find(org_user).name
  end

end
