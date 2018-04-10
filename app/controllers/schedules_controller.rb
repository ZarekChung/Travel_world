class SchedulesController < ApplicationController
  before_action :set_schedule, only: [:review, :show,:get_new_details]
  before_action :set_detail, only: [:review, :show]
  #排定行程method
  def review
    @event = Event.find(params[:event_id])
    @categories = Category.all
  end

  def show
    @details = @schedule.details
    render :layout => false
  end

  def get_new_details
    #@schedule= Schedule.find(params[:id])
    @spots = @schedule.spots
    render :json => { :spots => @spots }
  end

  def get_distance
    #@schedule = Schedule.find(params[:id])
    @from =@schedule.spots.first
    @to = @schedule.spots.last
    origin = GoogleDistanceMatrix::Place.new lat: @from.lat, lng: @from.lng
    destination = GoogleDistanceMatrix::Place.new lat: @to.lat, lng: @to.lng



@matrix = GoogleDistanceMatrix::Matrix.new(
  origins: [origin],
  destinations: [destination],
  language: I18n.locale
)
@matrix.configure do |config|
  #config.sensor = true
  config.mode = "transit"
  transit_mode = "bus"
   config.google_api_key = GoogleKey
end
  #render :json => { :matrix => matrix }
  #render :layout => false
  end

  private
  def set_schedule
    @schedule = Schedule.find(params[:id])
  end

  def set_detail
    @details = @schedule.details
  end


end
