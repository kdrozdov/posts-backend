class Post < ApplicationRecord
  include Posts::Searchable
  include Sortable

  mount_uploader :image, ImageUploader
  paginates_per 10

  belongs_to :user

  validates :title, presence: true

  accepts_nested_attributes_for(:user)
end
