class Twit < ApplicationRecord
  belongs_to :user
  has_many :retweets
  validates :body, presence: true, length: { maximum: 280 }
end
