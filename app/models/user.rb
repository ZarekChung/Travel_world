class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  mount_uploader :avatar, AvatarUploader
  validates_presence_of :name  #設定必填
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:facebook, :google_oauth2]

  has_many :replies, -> { order(created_at: :desc) }, dependent: :destroy
  has_many :replied_events, -> { where('disable = ?', false) }, through: :replies, source: :event

  has_many :favorites, -> { order(created_at: :desc) }, dependent: :destroy
  has_many :favorited_events, through: :favorites, source: :event

  has_many :events_of_users, -> { order(created_at: :desc) },dependent: :destroy
  has_many :contributed_events, -> { where('disable = ? and org_user IS ?', false, nil)}, through: :events_of_users, source: :event
  has_many :cloned_events, -> { where('org_user != user_id')}, through: :events_of_users, source: :event

  def admin?
    self.role == "admin"
  end

  def suspend?
    self.role == "suspend"
  end

  def self.find_for_google_oauth2(access_token, signed_in_resource=nil)
    data = access_token.info
    user = User.where(:google_token => access_token.credentials.token, :google_uid => access_token.uid ).first    
    if user
      return user
    else
      existing_user = User.where(:email => data["email"]).first
      if  existing_user
        existing_user.google_uid = access_token.uid
        existing_user.google_token = access_token.credentials.token
        existing_user.save!
        return existing_user
      else
    # Uncomment the section below if you want users to be created if they don't exist
        user = User.create(name: data["name"],
            email: data["email"],
            password: Devise.friendly_token[0,20],
            avatar: data["image"],
            gender: access_token.extra.raw_info.gender,
            google_token: access_token.credentials.token,
            google_uid: access_token.uid
        )
      end
    end
  end

  def self.from_omniauth(auth)

    # Case 1: Find existing user by facebook uid
    user = User.find_by_fb_uid( auth.uid )
    if user
      user.fb_token = auth.credentials.token
      user.save!
      return user
    end

    # Case 2: Find existing user by email
    existing_user = User.find_by_email( auth.info.email )
    if existing_user
      existing_user.fb_uid = auth.uid
      existing_user.fb_token = auth.credentials.token
      existing_user.save!
      return existing_user
    end

    # Case 3: Create new password
    user = User.new
    user.fb_uid = auth.uid
    user.fb_token = auth.credentials.token
    user.email = auth.info.email
    user.password = Devise.friendly_token[0,20]
    user.name = auth.info.name
    user.avatar = auth.info.image
    user.gender = auth.extra.raw_info.gender
    user.save!
    return user
  end


end
