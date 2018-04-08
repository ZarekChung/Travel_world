class DetailsController < ApplicationController
  before_action :set_detail, only: [:show, :edit, :update, :destroy]

  def new
    #找出spot
    @detail = Detail.new
    @spot = Spot.find_by(place_id:params[:placeId])
    @urlArray = @spot.getPhoto
    render :layout => false
  end

  def edit
    @spot = @detail.spot
    @urlArray = @spot.image.split(',')
    @schedule = @detail.schedule

    render :layout => false
  end

  def update
    params[:detail].parse_time_select! :strat_t
    @schedule = @detail.schedule
    if @detail.update_attributes(detail_params)
       @msgResult = "detail was scuccessfully updated"
     else
       @msgResult = "detail was failed to update"
    end
  end


 def show
    render :layout => false
 end

 def create
    @schedule = Schedule.find(params[:detail][:schedule_id])

    #要有如果找不到的防呆
    @spot = Spot.find(params[:detail][:spot_id])
    params[:detail].parse_time_select! :strat_t
    @detail = @spot.details.build(detail_params)

    @detail.schedule = @schedules

    if @detail.save
      @msgResult = "detail was scuccessfully created"
     else
      @msgResult = "detail was failed to create"
     end
  end

  def destroy
    @schedule = @detail.schedule
    @spots = @schedule.spots
    @detail.destroy
    @msgResult = "detail was deleted!"
  end

  private
  def set_detail
    @detail = Detail.find(params[:id])
  end

  def detail_params
    params.require(:detail).permit(:name, :hr, :category_id, :content,:strat_t,:spot_id,:schedule_id)

  end



end
