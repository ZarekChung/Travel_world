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

  #取照片要另外呼叫方法
  def get_phtot
    @client = GooglePlaces::Client.new(GoogleKey)
    @spot = @client.spot(params[:place_id], {language: 'zh'})
    @urlArray = Array.new
    @spot.photos.take(5).each do |photo|
      @urlArray.push(photo.fetch_url(800))
    end
    #url =  @spot.photos[0].fetch_url(800)
    render :json => { :url => @urlArray}
  end
end
