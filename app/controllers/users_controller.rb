class UsersController < ApplicationController

  def events
    @user = User.find(params[:id])
    @events = @user.events.all
    @favorites = @user.fav_events.all
    @reply_events = @user.replied_events.all
  end
end
