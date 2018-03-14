class EventsController < ApplicationController

  def index
    @events = Event.all
  end

  def show
    @event = Event.find(params[:id])
    @schedules = @event.schedules.all
    @schedules.each do |schedule|
      @details = schedule.details.all
    end
    @replies = @event.replies.all
  end

  def search
    @events = Event.search(params[:search])
  end
end
