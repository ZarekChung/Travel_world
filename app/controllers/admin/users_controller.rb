class Admin::UsersController < Admin::BaseController

  def index
    @users = User.all
  end

  def update
    @user = User.find(params[:id])
    @user.update(role: "admin")
    flash[:notice] = "Successfull to add the new manager: #{@user.name}"
    redirect_back(fallback_location: root_path)
  end

  def suspend
    @user = User.find(params[:id])
    @user.update(role: "suspend")
    flash[:notice] = "Successfull to suspend user: #{@user.name}"
    redirect_back(fallback_location: root_path)
  end
end
