class SpotsController < ApplicationController
  def search
     @client = GooglePlaces::Client.new(GoogleKey)

    #category = Category.first
     category = Category.find_by(id:params[:category])


    if category.nil?
      #@category = Category.find(params[:category])
      destination = params[:destination] 
    else
       destination = params[:destination] + category.name
    end

    spots = @client.spots_by_query( destination,:language => I18n.locale)
    render :json => { :spots => spots } 
  end

  def get_phtot
    @client = GooglePlaces::Client.new(GoogleKey)
    @spot = @client.spot(params[:place_id], {language: 'zh'})
    @urlArray = Array.new
    @spot.photos.take(5).each do |photo|
      @urlArray.push(photo.fetch_url(800))
    end
    render :json => { :url => @urlArray}
  end

  def new
    current_wish.add_wish_item(params[:placeId])
    spot = Spot.find_by(place_id:params[:placeId])
    render :json => { :spot => spot } 
  end
end
