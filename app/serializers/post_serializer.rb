class PostSerializer < ActiveModel::Serializer
  attributes :title, :body, :username
end
