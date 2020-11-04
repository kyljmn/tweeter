class TwitHashtag < ApplicationRecord
  belongs_to :twit
  belongs_to :hashtag

  validates :twit, uniqueness: { scope: :hashtag }
end
