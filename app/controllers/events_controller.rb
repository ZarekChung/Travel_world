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

  private

  def event_params
    params.require(:event).permit(:title, :info, :start_at, :end_at, :country, :district, :days)
  end

end
