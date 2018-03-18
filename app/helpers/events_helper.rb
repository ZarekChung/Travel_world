module EventsHelper

  def favorited?(event, user)
    event.favorites.where(user: user).exists?
  end

  def liked?(event, user)
    event.likes.where(user: user).exists?
  end

  def cloned?(event, user)
    event.events_of_users.where(user: user, creator: false).exists?
  end
end
