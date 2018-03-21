class EventsController < ApplicationController
  before_action :find_event, only: [:show, :favorite, :unfavorite,
                                    :clone]
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
    if params[:search]
      @events = Event.where("title LIKE ? OR country LIKE ? OR district LIKE ?", "%#{params[:search]}%", "%#{params[:search]}%", "%#{params[:search]}%").page(params[:page]).per(10)
    else
      @events = Event.all
    end

  end

  def clone
    @clone = Event.new(@event.attributes.except('id'))
    @org_user = EventsOfUser.find_org_user(@event)
    if @clone.save!
      current_user.events_of_users.create!(event: @clone, org_user: @org_user)
    end
    redirect_back(fallback_location: root_path)
  end

  # 共享功能
  # def share
  #   @clone = EventsOfUser.copy(@event)
  #   @clone.update_attributes(user: current_user, creator: false)
  # end


  protected

  def search_events(params)
    if params[:search]
      @events = Event.search(params[:search])
    else
      @events = Event.all
    end
  end


  private

  def find_event
    @event = Event.find(params[:id])
  end

end
