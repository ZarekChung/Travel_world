class SpotsController < ApplicationController
  def search
     @client = GooglePlaces::Client.new(GoogleKey)
     category = Category.find_by(id:params[:category])

    if category.id == Category.last.id
      destination = params[:destination]
    else
       destination = params[:destination] + " " + category.name
    end
    #交通在考慮要不要拿掉
    if category.id == Category.last(2).first.id
      spots = @client.spots_by_query( destination,:types => ['train_station','transit_station'],:language => I18n.locale)
    else
      spots = @client.spots_by_query( destination,:language => I18n.locale)
    end
    render :json => { :spots => spots }
  end

  def get_phtot
    @client = GooglePlaces::Client.new(GoogleKey)
    @spot = @client.spot(params[:place_id], {language: 'zh'})
    @urlArray = Array.new
    @spot.photos.take(5).each do |photo|
      @urlArray.push(photo.fetch_url(800))
    end
    render :json => { :url => @urlArray[0]}
  end

  def new
    current_wish.add_wish_item(params[:placeId])
    spot = Spot.find_by(place_id:params[:placeId])
    render :json => { :spot => spot }
  end
end
