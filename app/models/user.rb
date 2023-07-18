class User < ApplicationRecord
  has_many :user_parties
  has_many :parties, through: :user_parties

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates_presence_of :password_digest
  # validates :password, presence: true, confirmation: true
  # validates :password_confirmation, presence: true

  has_secure_password
end
