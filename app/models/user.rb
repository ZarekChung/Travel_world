class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :replies, dependent: :destroy

  has_many :likes, dependent: :destroy

  has_many :favorites, -> { order(created_at: :desc) }, dependent: :destroy

  has_many :events_of_users, -> { order(created_at: :desc) },dependent: :destroy
end
