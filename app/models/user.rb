class User < ApplicationRecord
  has_many :posts, dependent: :destroy

  validates :name, :phone, presence: true
end
