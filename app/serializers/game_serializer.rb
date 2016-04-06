class GameSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :price
end
