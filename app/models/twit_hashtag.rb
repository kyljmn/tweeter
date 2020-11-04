class TwitHashtag < ApplicationRecord
  belongs_to :twit, presence: true
  belongs_to :hashtag, presence: true
end
