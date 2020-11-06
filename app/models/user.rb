class User < ApplicationRecord
  has_many :twits, dependent: :destroy

  has_many :follows, dependent: :destroy

  has_many :follower_relationships, foreign_key: :following_id, class_name: "Follow"
  has_many :followers, through: :follower_relationships, dependent: :destroy

  has_many :following_relationships, foreign_key: :follower_id, class_name: "Follow"
  has_many :followings, through: :following_relationships, dependent: :destroy

  has_many :retwits, foreign_key: :owner_id, class_name: "Twit"

  has_many :mentions, dependent: :destroy
  
  has_many :notifications, foreign_key: :user_id, class_name: "Notification", dependent: :destroy

  has_one_attached :profile_picture, dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :username, presence: true, length: { minimum: 2 }, uniqueness: true

  validates :first_name, presence: true, length: { minimum: 2}

  validates :last_name, presence: true, length: { minimum: 2}

  validates :email, presence: true, uniqueness: true
  
  validates :password, presence: true
  
  def full_name
    return self.first_name + " " + self.last_name
  end

  def tweeter_handle
    return "@" + self.username
  end

  def profile_picture_validation
    if !profile_picture.content_type.in?(%('image/jpeg image/png'))
      errors.add(:profile_picture, 'needs to be a jpeg or png')
    end

    if profile_picture.byte_size > 5.megabytes
      errors[:profile_picture] << "each image should be less than 5MB" 
    end
  end
end
