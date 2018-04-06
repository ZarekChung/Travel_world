class Wish < ApplicationRecord
  has_many :wish_items, dependent: :destroy


   def add_wish_item(place_id)
      puts  "add_wish_item"
      puts place_id
      url = ""
      @client = GooglePlaces::Client.new(GoogleKey)
      spot = @client.spot(place_id,language: I18n.locale)

      spot.photos.each do |photo|
        url = url + photo.fetch_url(800) + ","
      end


      Spot.where(place_id: place_id).first_or_create do |newspot|
        newspot.image = url
        newspot.place_id = place_id
        newspot.address = spot.formatted_address
        newspot.rating = spot.rating
        newspot.lat = spot.lat
        newspot.lng = spot.lng
        newspot.spot_name = spot.name

    end

     
   
  end

end
