class Admin::EventsController < Admin::BaseController

  def index
    @events = Event.all.includes(:events_of_users).page(params[:page]).per(15)
  end

end
