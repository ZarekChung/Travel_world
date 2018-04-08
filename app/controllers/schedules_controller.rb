class SchedulesController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_suspend
  #排定行程method
  def new
    @event = Event.find(params[:event_id])
    @categories = Category.all
    @schedules = @event.schedules.first
    @details = @schedules.details
  end

  def show
    @schedule = Schedule.find(params[:id])
    @details = @schedule.details
    @spots = @schedule.spots
    @Category = Category.all
    render :layout => false
  end

  def get_distance
    @schedule = Schedule.find(params[:id])
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


end
