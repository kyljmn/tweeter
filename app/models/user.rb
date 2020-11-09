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

  validates :first_name, presence: true, length: { minimum: 2 }

  validates :last_name, presence: true, length: { minimum: 2 }

  validates :email, presence: true, uniqueness: true

  validates :password, presence: true

  def full_name
    "#{first_name} #{last_name}"
  end

  def tweeter_handle
    "@#{username}"
  end

  def profile_picture_validation
    errors.add(:profile_picture, "needs to be a jpeg or png") unless profile_picture.content_type.in?(%('image/jpeg image/png'))

    errors[:profile_picture] << "each image should be less than 5MB" if profile_picture.byte_size > 5.megabytes
  end
end
