class SchedulesController < ApplicationController
  before_action :set_schedule, only: [:review, :show,:get_new_details]
  before_action :set_detail, only: [:review, :show]
  #排定行程method
  def review
    @event = Event.find(params[:event_id])
    @categories = Category.all
    @googleUrl = ENV['GOOLE_PHOTO']

  end

  def show
    @details = @schedule.details.order(:sort).all
    render :layout => false
  end

  def get_new_details
    spots = Array.new
    details = @schedule.details.order(:sort).all
    details.all.each do |detail|
      spots.push(detail.spot)
    end
    render :json => { :spots => spots }
  end

  
  private
  def set_schedule
    @schedule = Schedule.find(params[:id])
  end

  def set_detail
    @details = @schedule.details
  end

end
