class ReviewSerializer < ActiveModel::Serializer
  attributes :id, :title, :body, :mark

  has_one :user, serializer: BasicUserSerializer
end
