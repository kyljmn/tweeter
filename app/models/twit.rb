class Twit < ApplicationRecord
  belongs_to :user

  has_many :retwits, foreign_key: :twit_id, class_name: "Retwit", dependent: :destroy

  has_many :mentions, dependent: :destroy
  
  has_one :post, foreign_key: :postable_id, class_name: "Post", dependent: :destroy

  validates :body, presence: true, length: { maximum: 280 }

  after_create do
    Post.create(user: self.user, postable: self)
  end
end
