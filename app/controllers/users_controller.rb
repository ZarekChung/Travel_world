class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:show, :edit, :update, :events]


  def events
    @favorites = @user.favorited_events
    @reply_events = @user.replied_events
    @myevents = @user.my_events
    @clones = @user.cloned_events
  end

  def edit 
    unless @user == current_user
      redirect_to user_path(@user)
    end
  end

  def update
    @user.update(user_params)
    redirect_to user_path(@user)
  end

  def show
    @favorited_events = @user.favorited_events
    @events_of_user = @user.events
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :introduction, :avatar, :gender, :email)
  end

end
