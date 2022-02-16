class User < ApplicationRecord
  has_many :attendees, dependent: :destroy
  has_many :parties, through: :attendees

  validates :name, presence: true 
  validates :email, uniqueness: true, presence: true
  validates :password_digest, presence: true
  has_secure_password
end
