class Post < ApplicationRecord
  belongs_to :user

  validates :title, presence: true

  accepts_nested_attributes_for(:user)
end
