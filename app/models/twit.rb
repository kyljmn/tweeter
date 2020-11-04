class Twit < ApplicationRecord
  belongs_to :user
  
  belongs_to :owner, foreign_key: :owner_id, class_name: "User", optional: true

  belongs_to :twit, foreign_key: :retwit_id, class_name: "Twit", optional: true

  has_many :retwits, foreign_key: :retwit_id, class_name: "Twit", dependent: :destroy

  has_many :mentions, dependent: :destroy

  validates :body, presence: true, length: { maximum: 280 }

  validates :twit, uniqueness: { scope: :user }, if: :is_retwit?

  def is_retwit?
    return !self.twit.nil?
  end

  def original
    return self unless self.is_retwit?
    return self.twit
  end
end
