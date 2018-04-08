class Spot < ApplicationRecord
  has_many :details ,dependent: :destroy
  #mount_uploader :image, AvatarUploader

  def getPhoto
    self.image.split(',')
  end
end
