class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :replies, -> { order(created_at: :desc) }, dependent: :destroy
  has_many :replied_events, through: :replies, source: :event

  has_many :likes, dependent: :destroy

  has_many :favorites, -> { order(created_at: :desc) }, dependent: :destroy
  has_many :fav_events, through: :favorites, source: :event

  has_many :events_of_users, -> { order(created_at: :desc) },dependent: :destroy
  has_many :events, through: :events_of_users, source: :event
  
end
