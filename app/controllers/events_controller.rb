class EventsController < ApplicationController
  before_action :find_event, only: [:show, :favorites, :unfavorite]

  def index
    @events = Event.all
  end

  def show
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
    current_user.favorites.create!(event: @event)
    redirect_back(fallback_location: root_path)
  end

  def unfavorite
    current_user.favorites.where(event: @event).destroy_all
    redirect_back(fallback_location: root_path)
  end

  def search
    @events = Event.search(params[:search])
  end

  private

  def find_event
    @event = Event.find(params[:id])
  end
end
