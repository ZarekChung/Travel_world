class UsersController < ApplicationController

  def events
    @user = User.find(params[:id])
    @favorites = @user.fav_events.all
    @reply_events = @user.replied_events.all
    @myevents = EventsOfUser.includes(:event).where(user: @user, creator: true)
    @clones = EventsOfUser.includes(:event).where(user: @user, creator: false)
  end
end
