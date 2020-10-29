class Retwit < ApplicationRecord
  belongs_to :twit, foreign_key: :twit_id, class_name: 'Twit' 
  belongs_to :retwiter, foreign_key: :retwiter_id, class_name: 'User'
  
  validates :twit, uniqueness: { scope: :retwiter }
end
