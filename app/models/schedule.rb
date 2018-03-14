class Schedule < ApplicationRecord
  belongs_to :event
  has_many :details, dependent: :destroy
end
