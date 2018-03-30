class Admin::EventsController < Admin::BaseController
  before_action :find_event, except: :index

  def index
    @events = Event.all.includes(:events_of_users).page(params[:page]).per(15)
  end

  def show
    @infos = Event.includes(schedules: { details: :spot}).find(params[:id])
    @replies = @event.replies
    @arg_num = @replies.blank? ? 0 : @replies.average(:number).round(2)
  end

  def unreport
    @event.update(report: !@event.report)
    redirect_back(fallback_location: root_path)
  end

  def disable
    @event.update(disable: !@event.disable)
    redirect_back(fallback_location: root_path)
  end

  private

  def find_event
    @event = Event.find(params[:id])
  end

end
