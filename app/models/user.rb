class User < ApplicationRecord
  has_many :twits, dependent: :destroy

  has_many :follows, dependent: :destroy

  has_many :follower_relationships, foreign_key: :following_id, class_name: 'Follow'
  has_many :followers, through: :follower_relationships

  has_many :following_relationships, foreign_key: :follower_id, class_name: 'Follow'
  has_many :followings, through: :following_relationships

  has_many :retweets, foreign_key: :retweeter_id, class_name: 'Retweet'
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :username, presence: true, length: { minimum: 2 }, uniqueness: true

  validates :first_name, presence: true, length: { minimum: 2}

  validates :last_name, presence: true, length: { minimum: 2}

  validates :email, presence: true, uniqueness: true
  
  validates :password, presence: true
  
end
