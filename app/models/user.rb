class User < ApplicationRecord
  validates :name, presence: true
  validates :password, presence: true, length: { minimum: 10, maximum: 16 }
end
