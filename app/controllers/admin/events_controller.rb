class Admin::EventsController < Admin::BaseController

  def index
    @events = Event.all.includes(:events_of_users).page(params[:page]).per(15)
  end

  def unreport
    @event = Event.find(params[:id])
    @event.update(report: !@event.report)
    redirect_back(fallback_location: root_path)
  end


end
