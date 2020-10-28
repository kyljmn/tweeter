class Retweet < ApplicationRecord
  belongs_to :tweet
  belongs_to :retweeter, foreign_key: :retweeter_id, class_name: 'User' 
end
