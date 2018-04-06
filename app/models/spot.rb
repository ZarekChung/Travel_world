class Spot < ApplicationRecord
  has_many :details ,dependent: :destroy
  #mount_uploader :image, AvatarUploader

  

  def add_spot(place_id)
  @client = GooglePlaces::Client.new(GoogleKey)
  spot = @client.spot(place_id, detail: true,language: I18n.locale)

    spot.photos.take(5).each do |photo|
      url = url + photo.fetch_url(800) + ","
    end


    Spot.where(place_id: place_id).first_or_create do |newspot|
        #newspot = spot,
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
