class PostSerializer < ActiveModel::Serializer
  attributes :title, :body, :username, :image

  def image
    {
      normal: object.image.normal.url,
      small: object.image.small.url
    }
  end

  def username
    object.user.name
  end
end
