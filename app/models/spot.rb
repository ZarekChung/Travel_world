class Spot < ApplicationRecord
  has_many :details
  mount_uploader :image, AvatarUploader
end
