class EventsController < ApplicationController
  before_action :find_event, only: [:show, :favorite, :unfavorite,
                                    :clone, :like, :unlike]
  before_action :authenticate_user!, except: [:index, :show, :search]

  def index
    @events = Event.all
  end

  def show
    @schedules = @event.schedules.all
    @replies = @event.replies.all
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

    respond_to do |format|
      format.html { redirect_back(fallback_location: root_path )}
      format.js
    end
  end

  def unfavorite
    current_user.favorites.where(event: @event).destroy_all

    respond_to do |format|
      format.html { redirect_back(fallback_location: root_path )}
      format.js
    end
  end

  def search
    @events = search_events(params)
  end

  def clone
    @clone = EventsOfUser.copy(@event)
    @clone.update_attributes(user: current_user, creator: false)
  end

  def like
    @like = @event.likes.create!(user: current_user)

    respond_to do |format|
      format.html { redirect_back(fallback_location: root_path )}
      format.js
    end
  end

  def unlike
    current_user.likes.where(event: @event).destroy_all

    respond_to do |format|
      format.html { redirect_back(fallback_location: root_path )}
      format.js
    end
  end


  protected

  def search_events(params)
    Event.search do
      fulltext params[:query]

      order_by :created_at, :desc
      paginate page: params[:page], per_page: 10
    end.results
  end


  private

  def find_event
    @event = Event.find(params[:id])
  end

end
