class Wish < ApplicationRecord
  has_many :wish_items, dependent: :destroy


   def add_wish_item(place_id,url)
    existing_item = wish_items.find_by( place_id: place_id )
    if existing_item
      #已經加入待選清單
      return false
    else
      @client = GooglePlaces::Client.new('AIzaSyDMu30RWUGZzxbJeWhOdaGDPFanAXM2eMM',:language => 'zh-tw')
      spot = @client.spot(place_id)
      wish_item = wish_items.build( lat:spot.lat, lng:spot.lng, place_id: place_id, spot_name: spot.name,image: url,address: spot.formatted_address,rating: spot.rating )
      wish_item.save!
      self.wish_items
      return true
    end
  end


end
