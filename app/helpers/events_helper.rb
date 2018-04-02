module EventsHelper

  def favorited?(event, user)
    event.favorites.where(user: user).exists?
  end

  def clone?(event, user)
    org_user = EventsOfUser.find_by(event: event).user
    EventsOfUser.where(user_id: user, org_user: org_user).exists? || 
    user.cloned_events.where(id: event).exists?
  end

  def myEvent?(event, user)
    user.contributed_events.where(id: event).exists?
  end

  def org_user_name(event)
    org_user = EventsOfUser.find_by(event: event).org_user
    User.find(org_user).name
  end

  def spot_img(event)
    event.schedules.first.spots.first unless event.schedules.first.nil?
  end

  def privacy_valid?(event, user)
    unless @event.privacy == false
      event.users.find_by(id: user.id).present?
    end
  end

end
