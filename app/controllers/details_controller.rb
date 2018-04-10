class DetailsController < ApplicationController
  before_action :set_detail, only: [:show, :edit, :update, :destroy]
  before_action :set_schedule, only: [:edit, :update, :destroy]

  def new
    @detail = Detail.new
    @spot = Spot.find_by(place_id:params[:placeId])
    @urlArray = @spot.getPhoto
    render :layout => false
  end

  def edit
    @spot = @detail.spot
    @urlArray = @spot.getPhoto
    render :layout => false
  end

  def update
    params[:detail].parse_time_select! :strat_t
    params[:detail].parse_time_select! :hr
    if @detail.update_attributes(detail_params)
       @msgResult = "detail was scuccessfully updated"
     else
       @msgResult = "detail was failed to update"
    end
  end
 #def show
#    render :layout => false
# end

 def create
    @schedule = Schedule.find(params[:detail][:schedule_id])
    @spot = Spot.find(params[:detail][:spot_id])
    params[:detail].parse_time_select! :strat_t
    params[:detail].parse_time_select! :hr
    @detail = @spot.details.build(detail_params)

    if @detail.save
      @msgResult = "detail was scuccessfully created"
     else
      @msgResult = "detail was failed to create"
     end

  end

  def destroy
    @spots = @schedule.spots
    @detail.destroy
    @msgResult = "detail was deleted!"
  end

  private
  def set_detail
    @detail = Detail.find(params[:id])
  end

  def set_schedule
    @schedule = @detail.schedule
  end

  def detail_params
    params.require(:detail).permit(:name, :hr, :category_id, :content,:strat_t,:spot_id,:schedule_id)

  end

end
