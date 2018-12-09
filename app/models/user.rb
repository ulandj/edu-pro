class User < ApplicationRecord
  has_many :channels, dependent: :destroy
end
