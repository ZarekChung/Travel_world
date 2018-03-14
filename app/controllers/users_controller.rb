class UsersController < ApplicationController

  def events
    @user = User.find(params[:id])
    @events = @user.events.all
  end
end
