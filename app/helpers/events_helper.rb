module EventsHelper

  def favorited?(event, user)
    event.favorites.where(user: user).exists?
  end

  def liked?(event, user)
    event.likes.where(user: user).exists?
  end

  def clone?(event, user)
    org_user = EventsOfUser.where(event: event).first.org_user
    EventsOfUser.cloned_event(user).where(org_user: org_user).exists?
  end

  def myEvent?(event, user)
    EventsOfUser.where(org_user: user, event: event).exists?
  end

end
