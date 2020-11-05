class Twit < ApplicationRecord
  belongs_to :user
  
  belongs_to :owner, foreign_key: :owner_id, class_name: "User", optional: true

  belongs_to :twit, foreign_key: :retwit_id, class_name: "Twit", optional: true

  belongs_to :reply_to, foreign_key: :reply_to_id, class_name: "Twit", optional: true

  has_many :retwits, foreign_key: :retwit_id, class_name: "Twit", dependent: :destroy

  has_many :mentions, dependent: :destroy

  has_many :twit_hashtags, dependent: :destroy

  has_many :hashtags, through: :twit_hashtags 

  has_many :replies, foreign_key: :reply_to_id, class_name: "Twit", dependent: :destroy;
  
  validates :twit, uniqueness: { scope: :user }, if: :is_retwit?

  has_many_attached :images, dependent: :destroy

  validates :body, presence: true, length: { maximum: 280 }

  validate :image_type

  def is_retwit?
    return !self.twit.nil?
  end

  def is_reply?
    return !self.reply_to.nil?
  end

  def original
    return self unless self.is_retwit?
    return self.twit
  end

  def image_type
    images.each do |image|
      if !image.content_type.in?(%('image/jpeg image/png'))
        errors.add(:images, 'needs to be a jpeg or png')
      end
      if image.byte_size > 5.megabytes
        errors[:images] << "each image should be less than 5MB" 
      end
    end
    if images.map(&:byte_size).sum > 20.megabytes
      errors[:images] << "Files data is too large" 
    end
    if images.count > 4
      errors[:images] << "Maximum of 4 images can be uploaded" 
    end
  end
end
