class User < ApplicationRecord
  has_many :channels, foreign_key: :user_id, dependent: :destroy

  validates :email, uniqueness: true, presence: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i }
end
