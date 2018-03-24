class Schedule < ApplicationRecord
  belongs_to :event
  has_many :details, dependent: :destroy
  has_many :spots, through: :details
  
  amoeba do
    enable 
  end
end
