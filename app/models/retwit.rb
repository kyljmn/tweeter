class Retwit < ApplicationRecord
  belongs_to :twit, foreign_key: :twit_id, class_name: "Twit"

  belongs_to :retwiter, foreign_key: :retwiter_id, class_name: "User"

  has_one :post, foreign_key: :postable_id, class_name: "Post"
  
  validates :twit, uniqueness: { scope: :retwiter }

  after_create do
    Post.create(user: self.retwiter, postable: self)
  end

  before_destroy do
    post = Post.where(user: self.retwiter, postable: self).first
    post.destroy
  end
end
