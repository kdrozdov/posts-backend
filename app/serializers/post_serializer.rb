class PostSerializer < ActiveModel::Serializer
  attributes :title, :body, :username, :image, :created_at

  def image
    {
      normal: object.image.normal.url,
      small: object.image.small.url
    }
  end

  def created_at
    object.created_at.strftime('%d/%m/%Y %H:%M')
  end

  def username
    object.user.name
  end
end
