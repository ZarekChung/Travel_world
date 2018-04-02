class Detail < ApplicationRecord
  belongs_to :schedule
  belongs_to :spot
  belongs_to :category
  #model validation
  validates_presence_of :hr, :category_id
end
