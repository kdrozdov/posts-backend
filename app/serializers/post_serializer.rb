class PostSerializer < ActiveModel::Serializer
  attributes :title, :body, :username

  def username
    object.user.name
  end
end
