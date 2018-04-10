class Admin::UsersController < Admin::BaseController

  def index
    @users = User.all.page(params[:page]).per(15)
  end

  def update
    @user = User.find(params[:id])
    @user.update(role: "admin")
    redirect_back(fallback_location: root_path)
  end

  def suspend
    @user = User.find(params[:id])
    @user.update(role: "suspend")
    redirect_back(fallback_location: root_path)
  end
end
