class Schedule < ApplicationRecord
  belongs_to :event
  has_many :details, dependent: :destroy
  has_many :spots, through: :details
  
  amoeba do
    enable 
  end

  def airplane_time_format
    if self.airplane_time 
      self.airplane_time.strftime("%I:%M%p")
    end
  end
end
