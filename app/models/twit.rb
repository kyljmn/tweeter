class Twit < ApplicationRecord
  belongs_to :user

  belongs_to :owner, foreign_key: :owner_id, class_name: "User", optional: true

  belongs_to :twit, foreign_key: :retwit_id, class_name: "Twit", optional: true

  belongs_to :reply_to, foreign_key: :reply_to_id, class_name: "Twit", optional: true

  has_many :retwits, foreign_key: :retwit_id, class_name: "Twit", dependent: :destroy

  has_many :mentions, dependent: :destroy

  has_many :twit_hashtags, dependent: :destroy

  has_many :hashtags, through: :twit_hashtags

  has_many :replies, foreign_key: :reply_to_id, class_name: "Twit", dependent: :destroy

  validates :twit, uniqueness: { scope: :user }, if: :retwit?

  has_many_attached :images, dependent: :destroy

  validates :body, presence: true, length: { maximum: 280 }

  validate :image_type

  def retwit?
    !twit.nil?
  end

  def reply?
    !reply_to.nil?
  end

  def original
    return self unless retwit?

    twit
  end

  def image_type
    images.each do |image|
      errors.add(:images, "needs to be a jpeg or png") unless image.content_type.in?(%('image/jpeg image/png'))
      errors[:images] << "each image should be less than 5MB" if image.byte_size > 5.megabytes
    end
    errors[:images] << "Maximum of 4 images can be uploaded" if images.count > 4
  end
end
