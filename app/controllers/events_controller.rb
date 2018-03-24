class EventsController < ApplicationController

  def index
  end

  def new
    @event = Event.new
    @schedule = Schedule.new
    @event.schedules.build
  end

  def create
    @event = Event.new(event_params)
    @schedule = @event.schedules.build
    if @event.save
      redirect_to schedules_event_path(@event,@schedule)
    else  
      flash[:alert] = "日期不可以空白!!"     
      render :new
    end
  end

  def schedules
    @event = Event.find(params[:id])
    @schedule = @event.schedules.find_by(event_id: @event)

    if @schedule.save

    else
      render :action => :schedule
    end
  end

  private

  def event_params
    params.require(:event).permit(:title, :info, :start_at, :end_at, :country, :district, :days, schedule: [:airplane_name, :airplane_number, :airplane_terminal, :airplane_time])
  end

  def schedule_params
    params.require(:schedule).permit(:day, :airplane_name, :airplane_number, :airplane_terminal, :airplane_time, :stay, :check_in, :check_out, :event_id)
  end

end
