class User < ApplicationRecord
  include Users::Authenticable

  has_many :posts, dependent: :destroy

  validates :name, :phone, presence: true
end
