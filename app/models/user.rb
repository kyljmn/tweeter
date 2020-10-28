class User < ApplicationRecord
  has_many :twits, dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :username, presence: true, length: { minimum: 2 }, uniqueness: true

  validates :first_name, presence: true, length: { minimum: 2}

  validates :last_name, presence: true, length: { minimum: 2}

  validates :email, presence: true, uniqueness: true
  
  validates :password, presence: true
  
end
