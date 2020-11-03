class Mention < ApplicationRecord
  belongs_to :twit

  belongs_to :user
  
  has_one :notification, foreign_key: :notifiable_id, class_name: "Notification", dependent: :destroy

  validates :user, uniqueness: { scope: :twit }
  after_create do
    Notification.create(user: self.user, notifiable: self)
  end
end
