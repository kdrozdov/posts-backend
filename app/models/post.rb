class Post < ApplicationRecord
  validates :title, :username, presence: true
end
