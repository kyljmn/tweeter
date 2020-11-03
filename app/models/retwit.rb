class Retwit < ApplicationRecord
  belongs_to :twit, foreign_key: :twit_id, class_name: "Twit"

  belongs_to :retwiter, foreign_key: :retwiter_id, class_name: "User"

  has_one :post, foreign_key: :postable_id, class_name: "Post", dependent: :destroy
  
  validates :twit, uniqueness: { scope: :retwiter }

  after_create do
    Post.create(user: self.retwiter, postable: self)
  end
end
