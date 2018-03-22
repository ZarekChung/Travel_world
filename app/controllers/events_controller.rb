class EventsController < ApplicationController

  def index
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    if @event.save
      redirect_to schedules_event_path(@event)
    else  
      flash[:alert] = "日期不可以空白!!"     
      render :new
    end
  end

  def schedules
    @event = Event.find(params[:id])
    @schedule = @event.schedules.new()
    @schedule.save
  end

  private

  def event_params
    params.require(:event).permit(:title, :info, :start_at, :end_at, :country, :district, :days)
  end

  def schedule_params
    params.require(:schedule).permit(:day, :airplane_name, :airplane_number, :airplane_terminal, :airplane_time, :stay, :check_in, :check_out, :event_id)
  end

end
