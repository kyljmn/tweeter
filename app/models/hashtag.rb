class Hashtag < ApplicationRecord
  has_many :twit_hashtags, dependent: :destroy

  has_many :twits, through: :twit_hashtags

  validates :name, presence: true, uniqueness: true, length: {maximum:279}
end
