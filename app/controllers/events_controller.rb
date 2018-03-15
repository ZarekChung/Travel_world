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
    @reply = @event.replies.new
    if @replies.blank?
      @arg_num = 0
    else
      @arg_num = @replies.average(:number).round(2)
    end
  end

  def search
    @events = Event.search(params[:search])
  end
end
