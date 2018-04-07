class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  #protect_from_forgery prepend: true, with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_locale
  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :gender])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :gender])
  end

  helper_method :current_wish
  #設定expore time
  helper_method :check_expires

  def set_locale
    if params[:locale] && I18n.available_locales.include?( params[:locale].to_sym )
    session[:locale] = params[:locale]
    end


    I18n.locale = session[:locale] || I18n.default_locale
  end
  #設定待選清單
  private

  def after_sign_in_path_for(resource)
    if session[:event].present?
      @event = Event.find_by(id: session[:event]["id"])
      @event.update(session[:event])
      @event.events_of_users.create!(user: current_user, event: @event)
      session.delete(:event)
      event_path(@event)
    else
      # if there is no form data in session, proceed as normal
      super
    end
  end

  def authenticate_suspend
    if current_user.suspend?
      flash[:alert] = "你目前被停權了!如有問題請聯絡我們！"
      redirect_to root_path
    end
  end

  def current_wish
    @wish || set_wish # return @wish if @wish exist, or call set_wish
  end

  def set_wish

    if session[:wish_id]
      @wish = Wish.find_by(id: session[:wish_id])
    end

    @wish ||= Wish.create

    session[:wish_id] = @wish.id
    session[:expires_at] = Time.current + 2.hours
    @wish
  end

  #判斷待選清單的expire time,超過時間就刪除
  def check_expires
    if session[:expires_at] < Time.current
      #destroy wish
      @wish = Wish.find_by(id: session[:wish_id])
      @wish.destroy
    end

  end

end