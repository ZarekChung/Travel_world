class UsersController < ApplicationController

  def events
    @user = User.find(params[:id])
    @favorites = @user.fav_events.all
    @reply_events = @user.replied_events.all
    @myevents = EventsOfUser.find_myevent(@user)
    @clones = EventsOfUser.cloned_event(@user)
  end
end
