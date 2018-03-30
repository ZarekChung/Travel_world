class EventsController < ApplicationController
  before_action :find_event, except: [:index, :search]
  before_action :authenticate_user!, except: [:index, :show, :search]
  after_action :update_arg_num, only: [:show]

  def index
    @events = Event.where.not(report: true, disable: true).order('favorites_count DESC').limit(5)
  end

  def show
    @infos = Event.includes(schedules: { details: :spot}).find(params[:id])

    #@spot = @infos.schedules.first.spots.first

    @replies = @event.replies
    @reply = Reply.new
    #star rating 功能判別是否有reply，算出star總平均並取小數點後兩位
    @arg_num = @replies.blank? ? 0 : @replies.average(:number).round(2)
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
    #get event_type from session if it is blank
    params[:search] ||= session[:search]
    #save event_type to session for future requests
    session[:search] = params[:search]

    @events = Event.order_search_events(params[:search], params[:order]).page(params[:page]).per(10)
    @populars = Event.where.not(report: true).order('arg_nums DESC').limit(5)
  end

  def clone
    @clone = @event.amoeba_dup
    if @clone.save!
      @org_user = EventsOfUser.find_by(event: @event).user
      current_user.events_of_users.create!(event: @clone, org_user: @org_user.id)
    end
    redirect_back(fallback_location: root_path)
  end

  def report
    if @event.report == false
      @event.update_attributes(report: !@event.report)
      flash[:notice] = "已檢舉行程！"
    else
      flash[:alert] = "此行程已被檢舉！"
    end
    redirect_back(fallback_location: root_path)
  end

  # 共享feature
  # def share
  #   @share = EventsOfUser.copy(@event)
  #   @share.update_attributes(user: current_user, creator: false)
  # end

  private

  def find_event
    @event = Event.find_by(id: params[:id], disable: false)
  end

  def update_arg_num
    @event.update(arg_nums: @arg_num)
  end

end
