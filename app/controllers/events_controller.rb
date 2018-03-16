class EventsController < ApplicationController

  def index
    @events = Event.all
  end

  def show
    @event = Event.find(params[:id])
    @schedules = Schedule.joins(:event).where(event: @event)
    @replies = Reply.joins(:event).where(event: @event)
    @reply = Reply.new
    #star rating 功能判別是否有reply，並算出star總平均
    if @replies.blank?
      @arg_num = 0
    else
      @arg_num = @replies.average(:number).round(2)
    end
  end

  def favorite
    event = Event.find(params[:id])
    current_user.favorites.create!(event: event)
    redirect_back(fallback_location: root_path)
  end

  def unfavorite
    event = Event.find(params[:id])
    current_user.favorites.where(event: event).destroy_all
    redirect_back(fallback_location: root_path)
  end

  def search
    @events = Event.search(params[:search])
  end
end
